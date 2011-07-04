class ChangeReceiptDataTypeInReceipts < ActiveRecord::Migration

  def self.up
    change_column :receipts, :receipt_data, :text
  end

  def self.down
    change_column :receipts, :receipt_data, :string
  end
  
end
