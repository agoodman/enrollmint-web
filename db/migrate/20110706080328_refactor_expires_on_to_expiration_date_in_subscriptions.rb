class RefactorExpiresOnToExpirationDateInSubscriptions < ActiveRecord::Migration

  def self.up
    add_column :subscriptions, :expiration_date, :timestamp
    Subscription.all.each {|sub| sub.update_attributes(:expiration_date => sub.expires_on)}
    remove_column :subscriptions, :expires_on
  end

  def self.down
    add_column :subscriptions, :expires_on, :date
    Subscription.all.each {|sub| sub.update_attributes(:expires_on => sub.expiration_date)}
    remove_column :subscriptions, :expiration_date
  end

end
