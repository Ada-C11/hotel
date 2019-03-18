require_relative "manifest"
require_relative "reservation"
require_relative "custom_exceptions"

module Hotel
  class Booker
    attr_reader :manifest

    def initialize(manifest: Manifest.new)
      @manifest = manifest
    end

    def book(reservation:, room:, percent_discount: 0)
      unless room.available_for_date_range?(date_range: reservation.date_range)
        raise RoomNotAvailable.new("Room #{room.id} not available for requested dates")
      end
      calculate_cost_of_booking(reservation: reservation, room: room, percent_discount: percent_discount)
      room.unavailable_list << reservation
      return room
    end

    def set_aside_block(block:, rooms_collection:)
      raise InvalidBlock.new if rooms_collection.length > 5
      rooms_collection.each do |room|
        unless room.available_for_date_range?(date_range: block.date_range)
          raise RoomNotAvailable.new("Room #{room.id} not available for requested dates in Block. Block aborted, no rooms added.")
        end
      end
      block.set_number_available(rooms_collection.length)
      rooms_collection.each do |room|
        room.unavailable_list << block
      end
    end

    def calculate_cost_of_booking(reservation:, room:, percent_discount: 0)
      reservation.cost = room.cost_per_night * reservation.duration_in_days * (100 - percent_discount) / 100.0
    end

    def get_cost_of_booking(reservation:)
      return reservation.cost
    end

    def book_room_with_block(block:, room:)
      raise InvalidBlock.new("Room not in block") unless room.has_unavailable_object?(unavailable_object: block)
      room.remove_unavailable_object(unavailable_object: block)
      book(reservation: Reservation.new(check_in: block.check_in,
                                        check_out: block.check_out),
           room: room,
           percent_discount: block.percent_discount)
      block.decrease_number_available
    end
  end
end
