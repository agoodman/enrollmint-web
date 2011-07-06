class CreateCouriers < ActiveRecord::Migration
  def self.up
    create_table :couriers do |t|
      t.string :post_back_url
      t.integer :subscription_id

      t.timestamps
    end
  end

  def self.down
    drop_table :couriers
  end
end
