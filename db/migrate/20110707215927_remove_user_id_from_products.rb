class RemoveUserIdFromProducts < ActiveRecord::Migration

  def self.up
    remove_column :products, :user_id
  end

  def self.down
    add_column :products, :user_id, :integer
  end
  
end
