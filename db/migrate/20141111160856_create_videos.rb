class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :image_url
      t.string :title
      t.string :description
      t.string :href_id

      t.timestamps
    end
  end
end
