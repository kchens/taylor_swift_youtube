get "/" do
  redirect "/signup"
end

get "/product/:product_id" do
  @product = Product.find(params[:product_id])
  erb :""
end

post "/product/:product_id" do

end

get "wishlist/:user_id" do

end
