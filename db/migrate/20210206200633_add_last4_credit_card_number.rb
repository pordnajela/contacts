class AddLast4CreditCardNumber < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :last_four_credt_card_numbers, :string
  end
end
