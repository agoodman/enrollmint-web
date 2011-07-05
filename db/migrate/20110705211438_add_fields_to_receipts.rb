class AddFieldsToReceipts < ActiveRecord::Migration

  def self.up
    add_column :receipts, :quantity, :integer
    add_column :receipts, :product_id, :integer
    add_column :receipts, :transaction_id, :string
    add_column :receipts, :purchase_date, :timestamp
    add_column :receipts, :expiration_date, :timestamp
    remove_column :receipts, :receipt_data
  end

  def self.down
    remove_column :receipts, :quantity
    remove_column :receipts, :product_id
    remove_column :receipts, :transaction_id
    remove_column :receipts, :purchase_date
    remove_column :receipts, :expiration_date
    add_column :receipts, :receipt_data, :text
  end

end
