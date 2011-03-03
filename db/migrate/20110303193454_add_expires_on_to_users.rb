class AddExpiresOnToUsers < ActiveRecord::Migration

  def self.up
    add_column :users, :expires_on, :date
  end

  def self.down
    remove_column :users, :expires_on
  end
  
end
