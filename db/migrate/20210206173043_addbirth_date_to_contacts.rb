class AddbirthDateToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :birth_date, :string
  end
end
