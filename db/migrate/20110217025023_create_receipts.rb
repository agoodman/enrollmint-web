class CreateReceipts < ActiveRecord::Migration
  def self.up
    create_table :receipts do |t|
      t.integer :customer_id
      t.string :receipt_data

      t.timestamps
    end
  end

  def self.down
    drop_table :receipts
  end
end
