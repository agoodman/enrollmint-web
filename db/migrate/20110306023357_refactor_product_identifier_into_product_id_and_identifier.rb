class RefactorProductIdentifierIntoProductIdAndIdentifier < ActiveRecord::Migration

  def self.up
    add_column :subscriptions, :product_id, :integer
    
    Subscription.all.each do |subscription|
      product = Product.find_or_create_by_identifier(subscription.product_identifier, :duration => 1.month)
      subscription.update_attribute(:product_id, product.id)
    end
    
    remove_column :subscriptions, :product_identifier
  end

  def self.down
    add_column :subscriptions, :product_identifier, :string
    
    Subscription.all.each do |subscription|
      subscription.update_attribute(:product_identifier, subscription.product.identifier)
    end

    remove_column :subscriptions, :product_id
  end
end
