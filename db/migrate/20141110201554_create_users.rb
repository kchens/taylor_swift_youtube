class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.string :password_hash
      t.string :access_token
      t.integer :expires
      t.string :fb_uuid

      t.timestamps
    end
  end
end