class AddSharedSecretToUsers < ActiveRecord::Migration

  def self.up
    add_column :users, :shared_secret, :string
  end

  def self.down
    remove_column :users, :shared_secret
  end
  
end
