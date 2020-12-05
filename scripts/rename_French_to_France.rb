french = Country.find_by(name: "French")
p french
french.name = "France"
french.save
p french

# Console should looks like that
# ➜  hops git:(split-brewery-addresses) ✗ rails runner scripts/rename_French_to_France.rb
# Running via Spring preloader in process 5848
# #<Country id: 1, name: "French", created_at: "2020-12-03 13:30:07", updated_at: "2020-12-05 20:06:48">
# #<Country id: 1, name: "France", created_at: "2020-12-03 13:30:07", updated_at: "2020-12-05 20:07:40">
