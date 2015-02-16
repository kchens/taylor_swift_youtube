require_relative '../lib/facebook'

####### CATEGORIES ######

get '/' do
  @categories = Category.all
  @original_categories = @categories.to_a.shift(5)
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

get '/search' do
  start_search = true
  @searched_category = Category.new(name: params[:query])
  if @searched_category.save
    @all_videos = Video.get_all_video_info("#{@searched_category.name}", start_search)
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
    redirect '/user/' + @user.id.to_s
  else
    @errors = @user.errors.full_messages
    erb :sign_up
  end
end

get '/user/:id' do
  @user = User.find(params[:id])
  erb :user
end

####### SIGN IN, SIGN OUT ######
get '/sessions/new' do
  erb :sign_in
end

get '/facebook/auth' do
  if current_user
    redirect '/'
  else
    session[:state] = User.create_api_state #prevent CSRF
    redirect "https://www.facebook.com/dialog/oauth?" +
      "client_id=#{ENV['FB_ID']}" +
      "&redirect_uri=http://localhost:9393/facebook/code&scope=email" +
      "&state=#{session[:state]}"
  end
end

get '/facebook/code' do
  fb_code = params['code']

  if params['state'] == session[:state]
    user_info = Facebook::User.get_user_info(fb_code)
    user_id = user_info['id']

    if User.exists?(user_id) && user_info['expiration_seconds'] > 0
      "User already in database"
      user = User.find_by(fb_uuid: user_id)
    else
      user = User.create_with_facebook(user_info)
    end

    session[:user_id] = user ? user.id : current_user.id
    redirect '/user/' + "#{session[:user_id]}"
  else
    "CSRF ATTACK!"
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

#####To Adhere to Convention:  Helper Methods Inteded For Views#########
def controller_add_commas(integer)
  integer.to_s.reverse.scan(/(?:\d*\.)?\d{1,3}-?/).join(',').reverse
end

########################################################

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
