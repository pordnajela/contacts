class ContactsController < ApplicationController
  
  def index
    # 
  end

  def manage_csv
    file_path = params.permit(:file)['file'].try(:path)
    result = ::ManageContactsCsv.new({file_path: file_path}).call


    redirect_to root_path, notice: ""
  end

end