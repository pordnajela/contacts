class CreateContact < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :email
      t.string :name
      t.string :phone_number
      t.string :address
      t.string :credit_card
      t.string :franchise
      t.datetime :attended_at
      t.timestamps
    end
  end
end
