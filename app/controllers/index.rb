get '/' do    #categories route
  # renders all categories
  @category = Category.all

  erb :categories
end

get '/category/:id' do
  @category = Category.find(params[:id])
  @videos = @category.videos
  erb :category
end

get '/video/:id' do
  @video = Video.find(params[:id])
  erb :video
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
  p "in sessions" * 50
  p @user = User.find_by(username: params[:user][:username])
  # if @user && @user.authenticate(params[:password])
  #   session[:user_id] = @user.id
  #   redirect '/'
  # else
  #   erb :sign_in
  # end
end


get '/favorites' do
  @liked =
  @love
  # erb :favorites
end

###### AJAX ######

post '/video/:id/like' do

end

post '/video/:id/love' do

end