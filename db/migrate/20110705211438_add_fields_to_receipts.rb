class AddFieldsToReceipts < ActiveRecord::Migration

  def self.up
    add_column :receipts, :quantity, :integer
    add_column :receipts, :product_id, :integer
    add_column :receipts, :transaction_id, :integer, :limit => 8
    add_column :receipts, :purchase_date, :timestamp
    add_column :receipts, :expiration_date, :timestamp
    remove_column :receipts, :receipt_data
  end

  def self.down
    remove_column :receipts, :quantity, :integer
    remove_column :receipts, :product_id, :integer
    remove_column :receipts, :transaction_id, :integer
    remove_column :receipts, :purchase_date, :timestamp
    remove_column :receipts, :expiration_date, :timestamp
    add_column :receipts, :receipt_data, :text
  end

end
