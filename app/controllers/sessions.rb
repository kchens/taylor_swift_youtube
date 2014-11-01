get "/signup" do
  erb :"sessions/signup"
end

post "/signup" do
  user = User.create(params[:user])
  session[:user_id] = user.id
  redirect "/product/1"
end

get "/login" do
  erb :"sessions/login"
end

post "/login" do
  user = User.find_by(email: params[:email])
  if user
    if user.password == params[:password]
      session[:user_id] = user.id
      redirect "product/1"
    else
      p "Incorrect password"
    end
  else
    p "Sorry, that user doesn't exist"
  end
end

get "/logout" do
  session[:user_id] = nil
  redirect "/"
end

##TODO
# Add in logic in post routes for login and sign up that direct user to the first product they haven't rated
# Add in logic in post login routes for incorrect password and email
# Add in validations for login and signup