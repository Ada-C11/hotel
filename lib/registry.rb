require 'date'
require_relative 'datespans.rb'
module Hotel

  class Registry
    attr_reader :rooms, :reservations

    def initialize
      @rooms = Hotel::Construction.new.rooms
      @reservations = []
    end

    def new_reservation(input)
      dates = [input[:check_in], input[:check_out]]
      res_id = @reservations.length + 1
      room = unoccupied_room(dates)
      reservation_data = {
        id: res_id,
        room: room,
        span: (dates[0..1])
      }

      new_res = Reservation.new(reservation_data)
      @reservations << new_res
    end

    def nice_room
      get first available room
    end

    def res_list
      @reservations.inspect
    end

    def find_by_date(date)
      date = Date.parse(date)
      by_date = @reservations.select do |entry|
        entry.date.find_in_range(date)
      end
      by_date
    end

    def find_in_range(given_span)
    in_range = @reservations.select do |entry|
      entry.span.overlaps?(given_span)
      end
      in_range
    end

    def available_rooms(span)
      conflicts = find_in_range(span)
      available_rooms = @rooms.reject do |room|
        conflicts.find do |entry|
          entry.rm_id == room[:rm_id]
        end
      end
      return available_rooms
    end
  end
end
