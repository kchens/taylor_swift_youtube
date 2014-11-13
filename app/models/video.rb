class Video < ActiveRecord::Base
  has_many :votes
  has_many :users, through: :votes

  has_many :category_videos
  has_many :categories, through: :category_videos

  validates :href_id, uniqueness: true, presence: true

  include HTTParty
  BASE_URI = "https://www.googleapis.com/youtube/v3/"

  def self.get_youtube_response(query)
    google_query = "Taylor Swift" + " " + query
    google_query = google_query.gsub!(' ', '+')
    @response = HTTParty.get(BASE_URI + "search", query: {
        key: ENV['API_KEY'],
        part: 'snippet',
        type: "video",
        q: "#{google_query}",
        maxResults: 16,
        channelId: "UCANLZYMidaCbLQFWXBC95Jg" #VEVO channel
      })
  end

  def self.parse_youtube_response
    keys = %i(image_url title description href_id)
    values = []
    @all_videos = []

    @response["items"].each do |video_json_hash|
      values << video_json_hash["snippet"]["thumbnails"]["high"]["url"] #image_urls
      values << video_json_hash["snippet"]["title"] #titles
      values << video_json_hash["snippet"]["description"] #descriptions
      values << video_json_hash["id"]["videoId"] #video_ids

      @all_videos << Hash[keys.zip(values)]
      values = []
    end
    return @all_videos
  end

  def self.add_video_stats(all_videos)
    @all_videos.map do |video_hash|
      @video_stats = HTTParty.get(BASE_URI + "videos", query: {
          key: ENV['API_KEY'],
          part: "statistics",
          id: "#{video_hash[:href_id]}"
        })
      video_hash.store(:view_count, @video_stats["items"][0]["statistics"]["viewCount"])
      video_hash.store(:like_count, @video_stats["items"][0]["statistics"]["likeCount"])
      # Turn "dislikes" into "loves"
      video_hash.store(:love_count, @video_stats["items"][0]["statistics"]["dislikeCount"])
    end
    return @all_videos
  end

  def self.get_all_video_info(query)
    self.get_youtube_response(query)
    self.parse_youtube_response
    self.add_video_stats(@all_videos)
  end

end


# https://www.googleapis.com/youtube/v3/search?part=snippet&q=Taylor+Swift&type=video&key=AIzaSyDYVdlJjPuCz5Nk8ruI_x7Vg-HVgLiuJrI&channelId=UCANLZYMidaCbLQFWXBC95Jg


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