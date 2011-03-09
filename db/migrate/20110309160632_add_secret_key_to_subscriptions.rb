class AddSecretKeyToSubscriptions < ActiveRecord::Migration

  def self.up
    add_column :subscriptions, :secret_key, :string
  end

  def self.down
    remove_column :subscriptions, :secret_key
  end
  
end
