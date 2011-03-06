class CreateProducts < ActiveRecord::Migration

  def self.up
    create_table :products do |t|
      t.integer :user_id
      t.string :identifier
      t.integer :duration

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end

end
