class AddSecretKeyToCustomers < ActiveRecord::Migration

  def self.up
    add_column :customers, :secret_key, :string
  end

  def self.down
    remove_column :customers, :secret_key
  end
  
end
