class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :image_url
      t.string :title
      t.string :description
      t.string :href_id
      t.integer :view_count
      t.integer :like_count
      t.integer :love_count


      t.timestamps
    end
  end
end
