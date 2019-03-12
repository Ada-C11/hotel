require_relative "room"
require_relative "reservation"
require "date"

module HotelSystem
  class Hotel
    attr_reader :rooms
    attr_accessor :reservations

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
      res_dates = reservation_dates(start_year: start_year, start_month: start_month, start_day: start_day, num_nights: num_nights)
      res_room = find_available_room(res_dates)
      id = create_reservation_id
      reservation = HotelSystem::Reservation.new(id: id, room: res_room, dates: res_dates)
      @reservations << reservation
      res_room.add_reservation(reservation)
    end

    def create_reservation_id
      if @reservations.length == nil
        return 1
      else
        id = @reservations.length + 1
        return id
      end
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
      res_room = find_room(room_number)
      dates.each do |date|
        if res_room.reservations == []
          return false
        else res_room.reservations.each do |res|
          if res.dates.include?(date)
          return true
          end
        end
      end
    end
      return false
    end

    def find_available_room(dates_list)
      @rooms.each do |res_room|
        reserved = room_reserved?(room_number: res_room.room_number, dates: dates_list)
        if !reserved
          return res_room
        end
      else
        return "Sorry, no available rooms for that date."
      end
    end

    def reservations_by_date(year:, month:, day:)
      date = Date.new(year, month, day)
      date_reservations = []
      @reservations.each do |reservation|
        if reservation.dates.include?(date)
          found_res = {}
          found_res[:reservation_id] = reservation.id
          found_res[:room_number] = reservation.room_number
          date_reservations << found_res
        end
      end
      if date_reservations.length == 0
        puts "There are no dates for that reservation."
        return 0
      elsif date_reservations.length == 1
        puts "There's one reservation for that date. The reservation id is #{date_reservations[0][:reservation_id]} and the room number is #{date_reservations[0][:room_number]}."
        return date_reservations
      else
        puts "Here's a list of the reservations for that date: #{date_reservations}."
        return date_reservations
      end
    end
  end
end
