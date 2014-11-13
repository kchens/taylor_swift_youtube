class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :image_url
      t.string :title
      t.string :description
      t.string :href_id
      t.string :view_count
      t.string :like_count
      t.string :love_count


      t.timestamps
    end
  end
end
