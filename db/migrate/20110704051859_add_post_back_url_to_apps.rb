class AddPostBackUrlToApps < ActiveRecord::Migration

  def self.up
    add_column :apps, :post_back_url, :string
  end

  def self.down
    remove_column :apps, :post_back_url
  end
  
end
