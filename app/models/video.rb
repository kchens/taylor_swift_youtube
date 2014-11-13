class Video < ActiveRecord::Base
  has_many :votes
  has_many :users, through: :votes

  has_many :category_videos
  has_many :categories, through: :category_videos

  include HTTParty
  BASE_URI = "https://www.googleapis.com/youtube/v3/search"

  def self.get_youtube_response(query)
    google_query = query.gsub!(' ', '+')
    @response = HTTParty.get(BASE_URI, query: {
        key: ENV['API_KEY'],
        part: 'snippet',
        type: "video",
        q: "#{google_query}",
        videoCaption: "closedCaption"
      })
  end

  def self.parse_youtube_response
    keys = %i(image_url title description href_id)
    values = []
    @all_videos = []

    @response["items"].each do |video_hash|
      values << video_hash["snippet"]["thumbnails"]["high"]["url"] #image_urls
      values << video_hash["snippet"]["title"] #titles
      values << video_hash["snippet"]["description"] #descriptions
      values << video_hash["id"]["videoId"] #video_ids

      @all_videos << Hash[keys.zip(values)]
      values = []
    end
  end

  def self.get_all_video_info(query)
    self.get_youtube_response(query)
    self.parse_youtube_response
    self.save_to_database
    return @all_videos
  end

  def self.save_to_database
    @all_videos.each do |video_hash|
      video = Video.new(video_hash)
      unless video.save
        errors.add(:id, "Corrupt video data")
      end
    end
  end

end


# https://www.googleapis.com/youtube/v3/search?part=snippet&q=Taylor+Swift&type=video&videoCaption=closedCaption&key=AIzaSyDYVdlJjPuCz5Nk8ruI_x7Vg-HVgLiuJrI


# HTTParty.get("https://www.googleapis.com/youtube/v3/search?part=snippet&q=Taylor+Swift&type=video&videoCaption=closedCaption&key=AIzaSyDYVdlJjPuCz5Nk8ruI_x7Vg-HVgLiuJrI")

# HTTParty.get("https://www.googleapis.com/youtube/v3/search", query: {key: 'AIzaSyDYVdlJjPuCz5Nk8ruI_x7Vg-HVgLiuJrI', part: 'snippet', type: "video", q: "Taylor+Swift", videoCaption: "closedCaption"})


# VIDEO ID
# "items" => array of maxResults => "id" => "videoId"

# VIDEO INFO
# key="items"
# array of maxResult hashes
# => "snippet" hash
# *** "title" ***
# *** "description" ***
#       "thumbnail" =>"high" => "url"