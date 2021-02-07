class AddSucceededToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :succeeded, :boolean
  end
end
