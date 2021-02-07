class ContactFilesController < ApplicationController

  def list
    @contact_files = ContactFile.by_user(current_user).paginate(page: params[:page], per_page: 10)
    @headers = %w{nombre estado}
  end

end