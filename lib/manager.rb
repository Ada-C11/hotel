

require_relative "reservation"
require_relative "room"

class Manager
  attr_reader :rooms

  def initialize
    @rooms = rooms
  end

  def make_rooms
    @rooms = (1..20).to_a.map! do |room|
      Room.new(id: room)
    end
  end

  def all_reservations
    @reservations << book_reservation(vacant_room, check_in, check_out)
  end
end
