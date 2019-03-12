require 'date'

require_relative 'room'
require_relative 'reservation'
require_relative 'block'
require_relative 'date_range'

module Hotel
  class HotelDispatcher
    attr_reader :rooms, :reservations
    def initialize
      @rooms = Hotel::HotelDispatcher.list_all_rooms
      @reservations = []
      # @blocks = blocks || []
    end

    def self.list_all_rooms
      rooms = []
      20.times do |i|
        room = Hotel::Room.new(room_num: i+1)
        rooms << room
      end
      return rooms
    end


    def reserve(start_date, end_date)
      #find the first available room and reserves it by creating a new reservation 
      new_room = nil 
      @rooms.each do |room|
        if room.status == :AVAILABLE
          new_room = room 
        end
      end
      # @reservations.each do |reservation|
      #   if !revervation.date_range.is_overlapped?(start_date) && !reservation.date_range.is_overlapped?(end_date)
      #     room = reservation.room
      #   end
      # end
      new_reservation = Hotel::Reservation.new(
        start_date: start_date,
        end_date: end_date,
        room: new_room
      )
      @reservations << new_reservation
      new_reservation
    end

    def self.list_all_reservations
      reservations = []
      reservations << reservation
    end


    def find_reservation(date)
      #returns reservations for a specified date
    end

  end
end
