class Video < ActiveRecord::Base
  has_many :votes
  has_many :users, through: :votes

  has_many :category_videos
  has_many :categories, through: :category_videos

  validates :href_id, uniqueness: true, presence: true

  include HTTParty
  BASE_URI = "https://www.googleapis.com/youtube/v3/"


  #Refactor un-DRY Model Later
  def self.search(query)
    google_query = "Taylor Swift" + " " + query
    google_query = google_query.gsub!(' ', '+')
    @response = HTTParty.get(BASE_URI + "search", query: {
        key: ENV['API_KEY'],
        part: 'snippet',
        type: "video",
        q: "#{google_query}",
        maxResults: 8,
      })
  end

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

  def self.get_all_video_info(query, search = nil)
    if search == true
      self.search(query)
    else
      self.get_youtube_response(query)
    end
    self.parse_youtube_response
    self.add_video_stats(@all_videos)
  end

end