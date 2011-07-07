class AddSubscriptionIdToReceipts < ActiveRecord::Migration

  def self.up
    add_column :receipts, :subscription_id, :integer
    Receipt.all.each {|r| r.update_attributes(:subscription_id => Subscription.find_by_customer_id_and_product_id(r.customer_id,r.product_id).id)}
    remove_column :receipts, :customer_id
    remove_column :receipts, :product_id
  end

  def self.down
    add_column :receipts, :customer_id, :integer
    add_column :receipts, :product_id, :integer
    Receipt.all.each {|r| r.update_attributes(:customer_id => r.subscription.customer_id, :product_id => r.subscription.product_id)}
    remove_column :receipts, :subscription_id
  end
  
end
