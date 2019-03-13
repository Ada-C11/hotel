require 'date'
# require_relative 'reservation.rb'
# require_relative 'room.rb'

module Booking
  class Hotel
    attr_accessor :all_reservations, :all_rooms, :available_rooms, :block_of_rooms

    def initialize(max_rooms)
      @all_reservations = []
      @all_rooms = [*1..max_rooms]
        @all_rooms.map! do |a|
          Room.new(a)  
        end
    end
      @available_rooms = []
      @block_of_rooms = []

      def list_rooms
        return @all_rooms
      end

    # instead of reservation as a parameter, maybe give it checkin/checkout date and room number. this method can search for availability and create a reservation based on that
    def add_reservation(checkin_date, checkout_date)
      @all_reservations ||= []
      reservation = Booking::Reservation.new(check_availability(checkin_date, checkout_date).first, checkin_date, checkout_date)

      @all_reservations << reservation
      return reservation
    end

    def reservations_by_date(date)
      list = []
      @all_reservations.each do |reservation|
        if date == reservation.checkin_date
          list << reservation
        end
      end
      return list
    end

    def check_availability(checkin_date, checkout_date)
      all_rooms_array = all_rooms.map do |room|
        room.number
      end

      unavail_rooms = []
      all_reservations.each do |reservation|
        if (checkin_date <= reservation.checkin_date && checkout_date >= reservation.checkin_date) || 
          (checkin_date <= reservation.checkout_date && checkout_date >= reservation.checkout_date) ||
          (checkin_date >= reservation.checkin_date && checkout_date <= reservation.checkout_date)
          unavail_rooms << reservation.room_number
        end
      end
      
      @available_rooms = all_rooms_array - unavail_rooms
      if @available_rooms.length == 0
        raise ArgumentError, "There are no available rooms for that date."
      end

      return @available_rooms
    end

    def hotel_block(checkin_date, checkout_date, requested_rooms, discounted_rate)
      room_block = []
      @block_of_rooms ||= []
      i = 0
      
      if @block_of_rooms - requested_rooms == nil
        raise ArgumentError, "That room is already in a block."
      else
        requested_rooms.each do |reservation|
          unless check_availability(checkin_date, checkout_date).include?(requested_rooms[i]) 
          # || @block_of_rooms.include?(requested_rooms[i])
          raise ArgumentError, "This room is not available for your selected dates."
          else
          reserved_room = Booking::Room.new(requested_rooms[i])
          # reservation = Booking::Reservation.new(requested_rooms[i], checkin_date, checkout_date, cost: discounted_rate)
          room_block << reservation
          end
          i += 1
        end
      end
      # self.available_rooms = self.available_rooms - block_of_rooms
      @available_rooms = @available_rooms - room_block
      @block_of_rooms << room_block
      return room_block
    end
  end

  # current_date = checkin_date
  # while current_date <= checkout_date
  #   check if room is available for current date
  #   current_date += 1 day (however I want to increase the date 1 day)
  # end
  # as soon as we hit a day within that that isn't available, we can leave the loop and say it's "not available"
    

end
