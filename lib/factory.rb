require_relative "room"
require_relative "reservation"
require_relative "block"

module HotelFactory
  def self.date_range(date1, date2)
    return HotelSystem::DateRange.new(date1, date2)
  end

  def self.reservation(date_range:, room:, id:, block: nil)
    HotelSystem::Reservation.new(date_range: date_range,
                                 room: room,
                                 id: id,
                                 block: block)
  end

  def self.block(rooms:, date_range:, discount_rate:, id:)
    HotelSystem::Block.new(rooms: rooms,
                           date_range: date_range,
                           discount_rate: discount_rate,
                           id: id)
  end
end
