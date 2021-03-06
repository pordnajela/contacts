require 'csv'

class ManageContactsCsv

  def initialize(params={})
    @csv_file_path = params[:file_path]
    @user = params[:user]
    @filename = params[:filename]
  end

  def call
    new_contact_file = ContactFile.create(name: @filename, status: "En espera", user_id: @user.id)
    begin

      # Detect file encoding
      detection = CharlockHolmes::EncodingDetector.detect(File.read(@csv_file_path))
      encoding = (detection[:encoding] == 'UTF-8') ? detection[:encoding].downcase : "#{detection[:encoding].downcase}:utf-8"
      # Read file and transform encoding to UTF-8
      file_content = File.open(@csv_file_path, "r:#{encoding}"){|f| f.read}
      # Replace semicolon separator for comma
      file_content = file_content.gsub(';', ',')

      headers = ::CSV.parse(file_content).first
      validate_headers = %w{nombre fecha_de_nacimiento telefono direccion tarjeta_de_credito email}
      
      contacts_added = 0
      some_errors = []

      if headers == validate_headers
        ::CSV.parse(file_content, converters: nil, headers: true) do |row|
          new_contact_file.update(status: "Procesando")
          new_contact_file.reload

          result = []

          name = validate_name(row["nombre"])
          result.push(name)
          birth_date = validate_birth_date(row["fecha_de_nacimiento"])
          result.push(birth_date)
          phone_number = validate_phone_number(row["telefono"])
          result.push(phone_number)
          address = validate_address(row["direccion"])
          result.push(address)
          credit_card = validate_credit_card(row["tarjeta_de_credito"])
          result.push(credit_card)
          email = validate_email(row["email"], new_contact_file.id)
          result.push(email)

          unless result.include?(nil)
            Contact.create(user_id: @user.id, contact_file_id: new_contact_file.id, email: email, name: name, phone_number: phone_number, address: address, credit_card: Digest::SHA256.new.hexdigest(credit_card.last), franchise: credit_card.first, birth_date: birth_date, last_four_credt_card_numbers: credit_card.last.last(4), succeeded: true)
            contacts_added = contacts_added + 1
            some_errors.push(false)
          else
            Contact.create(user_id: @user.id, contact_file_id: new_contact_file.id, email: email, name: name, phone_number: phone_number, address: address, credit_card: Digest::SHA256.new.hexdigest(credit_card.last), franchise: credit_card.first, birth_date: birth_date, last_four_credt_card_numbers: credit_card.last.last(4), succeeded: false)
            some_errors.push(true)
          end
  
        end
        
        if contacts_added > 0
          new_contact_file.update(status: "Terminado")
          new_contact_file.reload
        elsif some_errors.select {|e| e}.count == some_errors.count
          new_contact_file.update(status: "Fallido")
          new_contact_file.reload
        end

        return_message(true, {})
      else
        return_message(false, {error: "Nombre de columnas incorrectas"})
      end
    rescue => e
      new_contact_file.destroy
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")
      return_message(false, {})
    end
  end

  private

  def validate_email(email, contact_file_id)
    email_regex = /\A[^@\s]+@[^@\s]+\z/
    validate_email = email.match(email_regex)
    existing_contact = Contact.where(contact_file_id: contact_file_id, email: email).count
    
    if validate_email && existing_contact == 0
      email
    else
      nil
    end
  end

  def validate_phone_number(phone_number)
    phone_number_regex = /\(([+][0-9]{1,2})\)([ .-]?)([0-9]{3})(\s|[-])([0-9]{3})(\s|[-])([0-9]{2})(\s|[-])([0-9]{2})/
    validate_phone_number = phone_number.match(phone_number_regex)

    if validate_phone_number
      phone_number
    else
      nil
    end
  end

  def validate_name(name)
    name
  end

  def validate_birth_date(birth_date)
    begin
      date = Date.parse(birth_date)
      date_format = date.strftime("%F")
      
      if date_format == birth_date
        birth_date
      else
        nil
      end
   rescue ArgumentError
      nil
   end 
  end

  def validate_address(address)
    if address.empty?
      nil
    else
      address
    end
  end

  def validate_credit_card(credit_card)
    detector = CreditCardDetector::Detector.new(credit_card)
    franchise = detector.brand_name

    if franchise
      [franchise, credit_card]
    else
      nil
    end
  end

  def return_message(success, payload={})
    OpenStruct.new({success?: success, payload: payload})
  end
  
end