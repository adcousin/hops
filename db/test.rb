require 'open-uri'

beers = [
  { beer_name: "Leffe Ruby", color_name: "Ruby", style_name: "IPA", photo_key: 'https://www.punch-et-cocktail.com/media/catalog/product/cache/7/image/9df78eab33525d08d6e5fb8d27136e95/b/o/bouteille-biere-leffe-ruby.jpg' },
  { beer_name: "Leffe Tripel", color_name: "Blond", style_name: "tdb", photo_key: 'https://www.punch-et-cocktail.com/media/catalog/product/cache/7/image/9df78eab33525d08d6e5fb8d27136e95/b/o/bouteille-biere-leffe-triple.jpg' },
  { beer_name: "Leffe Blonde/Blond", color_name: "Blond", style_name: "tdb", photo_key: 'https://boutique.maltsethoublons.com/media/catalog/product/cache/16/image/9df78eab33525d08d6e5fb8d27136e95/b/o/bouteille-biere-leffe-blonde_1.jpg' },
  { beer_name: "Leffe Brune/Bruin", color_name: "Black", style_name: "tdb",  photo_key: 'https://boutique.maltsethoublons.com/media/catalog/product/cache/16/image/9df78eab33525d08d6e5fb8d27136e95/b/o/bouteille-biere-leffe-brune.jpg' },
  { beer_name: "Leffe Radieuse", color_name: "Ruby", style_name: "tdb", photo_key: 'https://www.bouteille-de-biere.com/media/catalog/product/cache/3/image/9df78eab33525d08d6e5fb8d27136e95/b/o/bouteille-biere-leffe-radieuse.jpg' },
  { beer_name: "Leffe Rituel 9°", color_name: "Blond", style_name: "tdb", photo_key: 'https://www.pompe-a-biere.com/media/catalog/product/cache/23/image/9df78eab33525d08d6e5fb8d27136e95/b/o/bouteille-biere-leffe-9.jpg' },
  { beer_name: "Orval", color_name: "Blond", style_name: "tdb", photo_key: 'https://www.trappist.be/media/1260/orval-orval-bi%C3%A8re-bier-beer.jpg?width=531&height=800' },
  { beer_name: "33 Export", color_name: "Blond", style_name: "tdb", photo_key: 'https://www.boissons-maroc.com/wp-content/uploads/2017/04/22366450_157263741532081_2078121316510643120_n.jpg' },
  { beer_name: "Guinness", color_name: "Black", style_name: "Stout", photo_key: 'https://www.papillesetpupilles.fr/wp-content/uploads/2017/12/Guinness-c-RyedaleWeb-CC0-Pixabay.jpg' },
  { beer_name: "Bière des Ours", color_name: "Blond", style_name: "tdb", photo_key: 'https://www.lecomptoirdecorinne.be/wp-content/uploads/2020/04/Bi%C3%A8re-des-ours-le-comptoir-de-corinne..png' },
  { beer_name: "Wychwood Hobgoblin Ruby", color_name: "Ruby", style_name: "Lambic", photo_key: 'https://www.wychwood.co.uk/wp-content/uploads/2019/01/shop-ruby.jpg' },
  { beer_name: "Dark Ruby Ale", color_name: "Ruby", style_name: "Ale", photo_key: 'https://untappd.akamaized.net/photos/2020_08_28/312c0690e35ac82e9a3a4ec52f2712c6_640x640.jpg' }
]

beers.each do |beer|
  p beer[:beer_name]
  b = Beer.find_by(name: beer[:beer_name])
  p b.id
  
  c = Color.find_by(name: beer[:color_name]) || Color.first
  p c.id
  
  s = Style.find_by(name: beer[:style_name]) || Style.first
  p s.id
  
  b.color = c
  b.style = s

  img = URI.open(beer[:photo_key])
  p img

  b.photo.attach(io: img, filename: "#{beer[:beer_name]}.jpg")
  p "Photo uploaded"
  b.save
end
