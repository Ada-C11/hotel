require "csv"

rooms = []

room_csv = CSV.open("support/rooms.csv", "w+", write_headers: true, headers: ["room_id", "cost"])
20.times do |id|
  room_hash = { "room_id" => id + 1, "cost" => 200.00 }
  room_csv << room_hash
  rooms << room_csv
end
