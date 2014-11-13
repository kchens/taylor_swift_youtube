class Category < ActiveRecord::Base
  has_many :category_videos
  has_many :videos, through: :category_videos

  validates :name, uniqueness: true


  def save_to_database(all_videos)
    pp "in save to database" * 5
    all_videos.each do |video_hash|
    pp "in video hash * 5"
      video = Video.new(video_hash)
      if video.save
        pp "in video save" * 5
        self.videos << video
      else
        pp video_hash
        pp "in else" * 5
      end
    end
  end
end
