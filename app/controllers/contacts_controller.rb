class ContactsController < ApplicationController
  
  def index
  end

  def list
    @user_contacts = Contact.by_user(current_user)
    @headers = %w{email nombre fecha_de_nacimiento telefono direccion franquicia ultimos_4_digitos}
  end

  def manage_csv
    file_path = params["upload_csv"]["file"].try(:path)
    result = ::ManageContactsCsv.new({file_path: file_path, user: current_user}).call
    if result.success?
      redirect_to contacts_path, notice: "Archivo cargado exitosamente"
    else
      redirect_to contacts_path, alert: "#{resilt.payload[:error]}"
    end
  end

end