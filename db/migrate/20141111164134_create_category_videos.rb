class CreateCategoryVideos < ActiveRecord::Migration
  def change
    create_table :category_videos do |t|
      t.belongs_to :video
      t.belongs_to :category

      t.timestamps
    end
  end
end
