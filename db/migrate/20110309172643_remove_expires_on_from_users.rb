class RemoveExpiresOnFromUsers < ActiveRecord::Migration

  def self.up
    remove_column :users, :expires_on
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
  
end
