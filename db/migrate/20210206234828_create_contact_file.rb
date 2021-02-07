class CreateContactFile < ActiveRecord::Migration[6.0]
  def change
    create_table :contact_files do |t|
      t.string :name
      t.string :status
    end
  end
end
