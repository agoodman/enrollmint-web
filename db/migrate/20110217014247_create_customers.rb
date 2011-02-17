class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.integer :user_id
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
