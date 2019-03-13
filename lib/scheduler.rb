module Scheduler
  def self.list_all_rooms
    all_rooms = Array.new
    20.times do |i|
      all_rooms << Room.new(i + 1)
    end
    return all_rooms
  end

  def find_available_room

  end
end