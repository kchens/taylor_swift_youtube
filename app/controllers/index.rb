# after do
#   ActiveRecord::Base.clear_active_connections!
# end

####### CATEGORIES ######

get '/' do
  @category = Category.all
  erb :categories
end

get '/category/:id' do
  @category = Category.find(params[:id])

  if @category.videos.empty?
    @all_videos = Video.get_all_video_info("#{@category.name}")
    @category.save_to_database(@all_videos)
    @videos = @category.videos
  else
    @videos = @category.videos
  end
  erb :all_videos
end

#Refactor so /search renders, but doesn't save to the database
get '/search' do
  search = true
  @searched_category = Category.new(name: params[:query])
  if @searched_category.save
    @all_videos = Video.get_all_video_info("#{@searched_category.name}", search)
    @searched_category.save_to_database(@all_videos)
    @videos = @searched_category.videos
  end
  erb :all_videos
end

####### USER ######

get '/users/new' do
  erb :sign_up
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect '/'
  else
    @errors = @user.errors.full_messages
    erb :sign_up
  end
end

####### SIGN IN, SIGN OUT ######
get '/sessions/new' do
  erb :sign_in
end

get '/facebook/auth' do
  @state = User.create_api_state
  redirect("https://www.facebook.com/dialog/oauth?client_id=#{ENV['FB_ID']}&redirect_uri=http://localhost:9292/facebook/code&scope=email&state=#{@state}")
end

get '/facebook/code' do
  fb_code = params['code']
  if params['state'] == User.get_api_state
    response = HTTParty.get("https://graph.facebook.com/oauth/access_token?client_id=#{ENV['FB_ID']}&redirect_uri=http://localhost:9292/facebook/code&client_secret=#{ENV['FB_SECRET']}&code=#{fb_code}")
  temp = response.split("&")
  keys, values = [], []
  temp.each do |string|
    b = string.split("=")
    keys << b[0]
    values << b[1]
  end

  pp keys
  pp values
  pp Hash[keys.zip(values)]

   # Create new user????
   # if this facebook_id is allready in
  end
end

post '/sessions' do
  @user = User.find_by(username: params[:user][:username])
  if @user && @user.authenticate(params[:user][:password])
    session[:user_id] = @user.id
    redirect '/'
  else
    @errors = "Can't find user with that username/password combination."
    erb :sign_in
  end
end

delete '/sessions/:id' do
  session[:user_id] = nil
  redirect '/'
end

###### USER SPECIFIC ######

# get '/favorites' do
#   @liked
#   @love
#   erb :favorites
# end

####### VIDEO ######

get '/video/:id' do
  @video = Video.find(params[:id])
  erb :video
end

post '/video/:id/like' do
  @video = Video.find(params[:id])
  @video.increment!(:like_count)
  @new_like_count = controller_add_commas(@video.like_count)
  if request.xhr?
    content_type :json
    @new_like_count.to_json
  else
    pp status 500
  end
end

post '/video/:id/love' do
  @video = Video.find(params[:id])
  @video.increment!(:love_count)
  @new_love_count = controller_add_commas(@video.love_count)
  if request.xhr?
    content_type :json
    @new_love_count.to_json
  else
    pp status 500
  end
end

#####To Adhere to Convention:  Helper Methods Inteded For Views#########
def controller_add_commas(integer)
  integer.to_s.reverse.scan(/(?:\d*\.)?\d{1,3}-?/).join(',').reverse
end