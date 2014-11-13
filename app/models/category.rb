class Category < ActiveRecord::Base
  has_many :category_videos
  has_many :videos, through: :category_videos

  validates :name, uniqueness: true


  def save_to_database(all_videos)
    all_videos.each do |video_hash|
      video = Video.new(video_hash)
      if video.save
        self.videos << video
      else
        pp self.videos << Video.find_by(href_id: video_hash[:href_id])
      end
    end
  end
end
