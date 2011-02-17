class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.integer :customer_id
      t.string :product_identifier
      t.date :expires_on

      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
