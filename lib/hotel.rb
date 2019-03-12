require 'date'
# require_relative 'reservation.rb'
# require_relative 'room.rb'

module Booking
  class Hotel
  MAX_ROOMS = 20
  attr_accessor :all_reservations, :all_rooms

  def initialize
    @all_reservations = []
    # @statuses = [:AVAILABLE, :BOOKED]
    @all_rooms = [*1..20]
      @all_rooms.map! do |a|
        Room.new(a)  
      end
  end

    # def self.add_room(room)
    #   @all_rooms << room
    # end

    def list_rooms
      return @all_rooms
    end

    # instead of reservation as a parameter, maybe give it checkin/checkout date and room number. this method can search for availability and create a reservation based on that
    def add_reservation(reservation)
      @all_reservations ||= []
      @all_reservations << reservation
      return @all_reservations
    end

    def reservations_by_date(date)
      list = []
      @all_reservations.each do |reservation|
        if date == reservation.checkin_date
          list << reservation
        end
      end
    end
    end


    # def change_status(new_reservation)
    #   self.add_reservation(new_reservation)
    #   @status = :BOOKED
    # end
  
    

end
