get "/" do
  redirect "/signup"
end

get "/product/:product_id" do
  @product = Product.find(params[:product_id])
  erb :"/products/product"
end

post "/product/:product_id" do
  @product = Product.find(params[:product_id])
  current_user
  if params[:pass]
    action = Action.create(liked: false)
    @product.actions << action
    @current_user.actions << action
  elsif params[:like]
    action = Action.create(liked: true)
    @product.actions << action
    @current_user.actions << action
  end
  p "/product/#{@product.id + 1}"
  redirect "/product/#{@product.id + 1}"
end

get "/wishlist/:user_id" do
  current_user
  erb :"/products/wishlist"
end
