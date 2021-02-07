class RemoveUserReferenceFromContacts < ActiveRecord::Migration[6.0]
  def change
    remove_column :contacts, :user_id
    add_reference :contacts, :contact_file, index: true
  end
end
