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