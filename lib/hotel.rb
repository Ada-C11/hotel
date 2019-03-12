require_relative "room"
require_relative "reservation"

module HotelSystem
  class Hotel
    attr_reader :rooms, :reservations

    def initialize
      @rooms = []
      (1..20).each do |num|
        room = HotelSystem::Room.new(num)
        @rooms << room
      end
      @reservations = []
    end

    def find_room(number)
      HotelSystem::Room.valid_room_number(number)
      return @rooms.find { |room| room.room_number == number }
    end

    def reserve_room(start_year:, start_month:, start_day:, num_nights:)
      dates = reservation_dates(start_year: start_year, start_month: start_month, start_day: start_day, num_nights: num_nights)
      room = find_available_room(dates)
      reservation = HotelSystem::Reservation.new(id: create_reservation_id, room: room, dates: dates)
      @reservations << reservation
      room.reservations << reservation
    end

    def create_reservation_id
      return @reservations.length + 1
    end

    def reservation_dates(start_year:, start_month:, start_day:, num_nights:)
      dates = []
      start_date = Date.new(start_year, start_month, start_day)
      dates << start_date
      i = 1
      num_nights.times do
        date = start_date + i
        dates << date
        i += 1
      end
      return dates
    end

    def room_reserved?(room_number:, dates:)
      room = find_room(room_number)
      dates.each do |date|
        if room.reservations.include?(date)
          return true
        end
      end
      return false
    end

    def find_available_room(dates)
      @rooms.each do |room|
        if !room_reserved?(room_number: room.room_number, dates: dates)
          return room
        end
      else
        return "Sorry, no available rooms for that date."
      end
    end

    def reservations_by_date(start_year:, start_month:, start_day:)
      date = Date.new(start_year, start_month, start_day)
      date_reservations = []
      @reservations.each do |reservation|
        if reservation.dates.include?(date)
          date_reservations << reservation
        end
      end
      if date_reservations.length == 1
        puts "There's one reservation "
      end
    end
      
  end
end

