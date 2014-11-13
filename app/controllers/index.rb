####### CATEGORIES ######

get '/' do    #categories route
  # renders all categories
  @category = Category.all
  erb :categories
end

get '/category/:id' do
  @category = Category.find(params[:id])

  if @category.videos.empty?
    pp @all_videos = Video.get_all_video_info("#{@category.name}")
    @category.save_to_database(@all_videos)
    pp @videos = @category.videos
  else
    pp @videos = @category.videos
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
    erb :sign_up
  end
end

####### SIGN IN, SIGN OUT ######
get '/sessions/new' do
  erb :sign_in
end

post '/sessions' do
  @user = User.find_by(username: params[:user][:username])
  if @user && @user.authenticate(params[:user][:password])
    session[:user_id] = @user.id
    redirect '/'
  else
    erb :sign_in
  end
end

delete '/sessions/:id' do
  session[:user_id] = nil
  redirect '/'
end

###### USER SPECIFIC ######

get '/favorites' do
  @liked
  @love
  # erb :favorites
end

####### VIDEO ######

get '/video/:id' do
  @video = Video.find(params[:id])
  erb :video
end

post '/video/:id/like' do

end

post '/video/:id/love' do

end