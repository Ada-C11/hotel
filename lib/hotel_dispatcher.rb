require 'date'

require_relative 'room'
require_relative 'reservation'
require_relative 'block'
require_relative 'date_range'

module Hotel
  class HotelDispatcher
    attr_accessor :rooms, :reservations
    def initialize
      @rooms = Hotel::Room.list_all_rooms
      @reservations = []
      # @blocks = blocks || []
    end

    def reserve(start_date, end_date)
      #find the first available room and reserves it by creating a new reservation 
      new_room = nil 
      available_rooms = find_available_room(start_date, end_date)
      available_rooms.each do |room|
        if room
          new_room = room
          break
        else 
          puts "There are currently no available rooms"
          new_room
        end
      end
      if new_room
        new_reservation = Hotel::Reservation.new(
          start_date: start_date,
          end_date: end_date,
          room: new_room
        )
        @reservations << new_reservation
        new_reservation
        end
    end


    def find_reservation(date)
      #returns reservations for a specified date
      reservation_by_date = []
      @reservations.each do |r|
        if r.date_range.is_included?(date)
          reservation_by_date << r
        end
      end
      return reservation_by_date
    end 

    def list_reserved_rooms(start_date, end_date)
      reserved_rooms = [] 
      @reservations.each do |r|
        if r.date_range.is_overlapped?(start_date, end_date)
          reserved_rooms << r.room
        end
      end
      return reserved_rooms
    end

    def find_available_room(start_date, end_date)
      available_rooms = []
      @rooms.each do |room|
        if !(list_reserved_rooms(start_date, end_date).include?(room))
          available_rooms << room
        end
      end
      return available_rooms
    end

  end
end
