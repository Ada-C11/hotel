require "csv"
require_relative "../lib/room"

rooms = []

room_csv = CSV.open("support/rooms.csv", "w+", write_headers: true, headers: ["room_id", "cost"])
Hotel::Room.num_rooms.times do |id|
  room_hash = { "room_id" => id + 1, "cost" => Hotel::Room.cost }
  room_csv << room_hash
  rooms << room_csv
end
