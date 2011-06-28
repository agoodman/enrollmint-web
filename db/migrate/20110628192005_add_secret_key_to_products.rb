class AddSecretKeyToProducts < ActiveRecord::Migration

  def self.up
    add_column :products, :secret_key, :string
  end

  def self.down
    remove_column :products, :secret_key
  end
  
end
