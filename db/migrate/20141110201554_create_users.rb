class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :password_hash
      t.string :access_token
      t.string :expires
      t.integer :fb_id

      t.timestamps
    end
  end
end