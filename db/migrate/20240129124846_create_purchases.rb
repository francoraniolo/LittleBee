class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.decimal :total_price
      t.boolean :active

      t.timestamps
    end
  end
end
