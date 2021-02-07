class AddingUserReferenceToContactFile < ActiveRecord::Migration[6.0]
  def change
    add_reference :contact_files, :user, index: true
  end
end
