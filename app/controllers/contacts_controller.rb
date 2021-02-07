class ContactsController < ApplicationController
  
  def index
  end

  def list
    @user_contacts = Contact.by_user(current_user).where(succeeded: true).paginate(page: params[:page], per_page: 10)
    @headers = %w{email nombre fecha_de_nacimiento telefono direccion franquicia ultimos_4_digitos archivo_de_contacto}
  end

  def list_failed_contacts
    @user_failed_contacts = Contact.by_user(current_user).where(succeeded: false).paginate(page: params[:page], per_page: 10)
    @headers = %w{email nombre fecha_de_nacimiento telefono direccion franquicia ultimos_4_digitos archivo_de_contacto}
  end

  def manage_csv
    if params["upload_csv"].nil?
      redirect_to contacts_path
    else
      file_path = params["upload_csv"]["file"].try(:path)
      filename = params["upload_csv"]["file"].try(:original_filename)
      result = ::ManageContactsCsv.new({file_path: file_path, user: current_user, filename: filename}).call
      if result.success?
        redirect_to contacts_path, notice: "Archivo cargado exitosamente"
      else
        redirect_to contacts_path, alert: "#{result.payload[:error]}"
      end
    end
    
  end

end