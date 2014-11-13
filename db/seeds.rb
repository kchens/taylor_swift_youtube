# 2.times do
#   b = Video.create(title: Faker::Commerce.color,
#               description: Faker::Lorem.sentence,
#               image_url: "http:")
#   2.times do
#     a = User.create(name: Faker::Name.first_name,
#                 email: Faker::Internet.email,
#                 password: Faker::Internet.password)
#     c = Vote.create(love: true)
#     a.votes << c
#     b.votes << c
#   end
# end

Category.create(name: "Hits")
# e1 = Category.create(name: "Country")
# e2 = Category.create(name: "Pop")

# f1 = CategoryVideo.create
# f2 = CategoryVideo.create

# Video.first.category_videos << f1
# Video.last.category_videos << f2

# e1.category_videos << f1
# e1.category_videos << f2


# a = User.create(name:"Jack")
# b = Video.create(name: "Tswift")
# c = Vote.create(love: true)
# a.votes << c
# a.videos # doesn't return anything
# b.votes << c
# b.users # returns user a



# d = Video.create(name: "Swizzle")
# e = Category.create(name: "Country")
# f = CategoryVideo.create()
# d.category_videos << f
# d.categories.first.name
# ==> "country"

# e.category_videos << f

# TEST: Video.first.categories
# TEST: Category.first.videos