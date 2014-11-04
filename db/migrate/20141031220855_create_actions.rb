class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.integer :user_id
      t.integer :product_id
      t.boolean :liked
      t.boolean :purchased
      t.timestamps
    end
  end
end
