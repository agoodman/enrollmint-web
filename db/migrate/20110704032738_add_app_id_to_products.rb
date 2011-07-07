require 'digest/sha1'

class AddAppIdToProducts < ActiveRecord::Migration

  def self.up
    add_column :products, :app_id, :integer
    Product.all.each do |product|
      app = product.user.apps.first
      if app.nil?
        app = App.create!(:title => "App#{product.user.apps.count+1}", 
                          :bundle_identifier => "your.bundle.#{Digest::SHA1.hexdigest("--#{Time.now}--#{rand}--")[0..9]}",
                          :user_id => product.user_id)
      end
      product.app_id = app.id
      product.save
    end
  end

  def self.down
    remove_column :products, :app_id
  end
  
end
