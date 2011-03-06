class AddApiTokenToUsers < ActiveRecord::Migration

  def self.up
    add_column :users, :api_token, :string
    User.all.each {|user| user.generate_api_token;user.save}
  end

  def self.down
    remove_column :users, :api_token
  end
  
end
