categories = ["Hits", "Live", "Country", "Pop"] # , "Winnie The Pooh"

categories.each do |category_name|
  Category.create(name: category_name)
end

# @category = Category.find_by(name: "Winnie The Pooh")
# @search = true
# @all_videos = Video.get_all_video_info("#{@category.name}", @search)
# @category.save_to_database(@all_videos)
# @videos = @category.videos