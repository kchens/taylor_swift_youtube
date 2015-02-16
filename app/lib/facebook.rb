module Facebook

  def self.make_auth_request(fb_code)
    @authorization_request_obj = HTTParty.get("https://graph.facebook.com/oauth/access_token?" +
      "client_id=#{ENV['FB_ID']}" +
      "&redirect_uri=http://www.taylortube2.herokuapp.com/facebook/code" +
      "&client_secret=#{ENV['FB_SECRET']}" +
      "&code=#{fb_code}")
  end

  def self.parse_auth_request
    @parsed_authorization = CGI::parse(@authorization_request_obj.body)
  end

  def self.make_info_request
    token = @parsed_authorization['access_token'].first
    user_info = HTTParty.get("https://graph.facebook.com/me/?access_token=#{token}").body
    @parsed_user_info = JSON.parse(user_info)
  end

  def self.add_expiration_date
    seconds_to_expiration = @parsed_authorization['expires'].first.to_i
    @parsed_user_info["expiration_seconds"] = seconds_to_expiration
  end

  def self.get_user_info
    @parsed_user_info
  end

  class User

    def self.get_user_info(fb_code)
      Facebook::make_auth_request(fb_code)
      Facebook::parse_auth_request

      Facebook::make_info_request

      Facebook::add_expiration_date
      Facebook::get_user_info
    end
  end

end