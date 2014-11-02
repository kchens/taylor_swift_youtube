require 'Faker'

User.create(name: "Meg Sandman", email: "meg@meg.com", password: "password")

5.times do
  User.create(name: Faker::Name.name, email: Faker::Internet.email, password: "password")
end

# 10.times do
#   Product.create(name: Faker::Commerce.product_name, designer: Faker::Company.name, price: Faker::Address.building_number, category: Faker::Commerce.department)
# end

Product.create(name: "Elsa Printed Dress", designer: "Madewell", price: 168, description: "A vibrant print adds eclectic charm to a flared silk Madewell dress. A gentle curve shapes the hem. On-seam hip pockets. Back button keyhole. 3/4 sleeves. Lined.", category: "Dress", url: "http://www.shopbop.com/elsa-printed-dress-madewell/vp/v=1/1568863221.htm?folderID=2534374302029428&fm=other-shopbysize&colorId=46196", image: "product-1.jpg")
Product.create(name: "Palo Alto 15\" Computer Tote", designer: "Rebecca Minkoff", price: 350, description: "A wrinkled leather Rebecca Minkoff computer tote. Open top and double handles. 2 main compartments with 1 zip pocket, 2 patch pockets, and an optional zip pouch. Padded center compartment with a zip closure for laptop storage. A zippered flap pocket trims the front. Polished hardware. Lined. Dust bag included.", category: "bag", url: "http://www.shopbop.com/palo-alto-computer-tote-rebecca/vp/v=1/1516511411.htm?folderID=2534374302029428&fm=other-shopbysize&colorId=12867", image: "product-2.jpg")
Product.create(name: "Astral Earring Jacket", designer: "Elizabeth and James", price: 195, description: "An optional starburst design inset with white topaz crystals accents the post closure on elegant Elizabeth and James earrings.", category: "jewlery", url: "http://www.shopbop.com/astral-earring-jacket-elizabeth-james/vp/v=1/1512055979.htm?folderID=2534374302029428&fm=other-shopbysize&colorId=66227", image: "product-3.jpg")
Product.create(name: "Watson Flare Dress", designer: "Rag & Bone", price: 595, description: "A pattered Rag & Bone dress has effortless style with a fit-and-flare skirt and tailored, yet casual bodice. Leather banding trims the crew neckline and the short raglan sleeves. Exposed back zip. Lined.", category: "dress", url: "http://www.shopbop.com/watson-flare-dress-rag-bone/vp/v=1/1523838601.htm?folderID=2534374302029428&fm=other-shopbysize&colorId=12867", image: "product-4.jpg")
Product.create(name: "Kaylee Suede Top", designer: "Just Female", price: 284, description: "Supple suede panels compose this boxy Just Female tank. Crew neckline. Hidden back zip.", category: "top", url: "http://www.shopbop.com/kaylee-suede-top-just-female/vp/v=1/1579477816.htm?folderID=2534374302029428&fm=other-shopbysize&colorId=16506", image: "product-5.jpg")
Product.create(name: "Sonar Wool Jacket", designer: "Helmut Lang", price: 395, description: "A lightweight wool Helmut Lang jacket balances a structured profile with a high, slouchy neckline. A single snap secures the placket, and an optional self-belt refines the silhouette. Welt hip pockets. Lined.", category: "jacket", url: "http://www.shopbop.com/sonar-wool-jacket-helmut-lang/vp/v=1/1511303673.htm?folderID=2534374302029428&fm=other-shopbysize&colorId=70983", image: "product-6.jpg")
Product.create(name: "Pure DKNY Sweatpants", designer: "DKNY", price: 160, description: "French terry DKNY sweatpants in a slouchy-slim cut. Slant hip pockets. Snug cuffs. Drawstring waist.", category: "pants", url: "http://www.shopbop.com/pure-dkny-sweatpant-drawstring/vp/v=1/1572201947.htm?folderID=2534374302029428&fm=other-shopbysize&colorId=12867", image: "product-7.jpg")
# Product.create(name: "", designer: "", price: , description: "", category: "", url: "", image: "/img/product-7.jpg")


