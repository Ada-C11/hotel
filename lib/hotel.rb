require_relative "room"
require_relative "reservation"
require_relative "date_range.rb"
require "date"

module HotelSystem
  class Hotel
    attr_reader :rooms
    attr_accessor :reservations

    def initialize(number_of_rooms)
      @rooms = []
      add_rooms(number_of_rooms)
      @reservations = []
    end

    def add_rooms(number)
      if number.class != Integer || number < 1
        raise ArgumentError, "Please enter a number greater than 1."
      end
      (1..number).each do |num|
        room = HotelSystem::Room.new(num)
        @rooms << room
      end
    end

    def valid_date_entry?(year, month, day)
      HotelSystem::DateRange.valid_date_entry?(year, month, day)
    end

    def create_date_list(start_year:, start_month:, start_day:, num_nights: nil)
      valid_date_entry?(start_year, start_month, start_day)
      dates = HotelSystem::DateRange.new(start_year: start_year, start_month: start_month, start_day: start_day, num_nights: num_nights)
      return dates
    end

    def find_room(number)
      HotelSystem::Room.valid_room_number(number)
      return @rooms.find { |room| room.room_number == number }
    end

    def room_reserved?(room_number:, year:, month:, day:)
      valid_date_entry?(year, month, day)
      res_room = find_room(room_number)
      date = Date.new(year, month, day)
      if res_room.reservations == []
        return false
      end
        res_room.reservations.each do |res|
          if res.date_range.include?(date)
            if date == res.date_range.checkout
              return false
            else
              return true
            end
          end
        end
      return false
    end

    def find_available_room(start_year:, start_month:, start_day:)
      valid_date_entry?(start_year, start_month, start_day)
      @rooms.each do |hotel_room|
        reserved = room_reserved?(room_number: hotel_room.room_number, year: start_year, month: start_month, day: start_day)
        if reserved == false
          return hotel_room
        end
      end
        raise NotImplementedError, "Sorry, no available rooms for that date."
    end

    def create_reservation_id
      if @reservations.length == nil
        return 1
      else
        id = @reservations.length + 1
        return id
      end
    end    

    def reserve_room(start_year:, start_month:, start_day:, num_nights:)
      valid_date_entry?(start_year, start_month, start_day)
      res_dates = create_date_list(start_year: start_year, start_month: start_month, start_day: start_day, num_nights: num_nights)
      # res_dates_range = res_dates.date_list
      res_room = find_available_room(start_year: start_year, start_month: start_month, start_day: start_day)
      id = create_reservation_id
      res = HotelSystem::Reservation.new(id: id, room: res_room, date_range: res_dates)
      @reservations << res
      res_room.add_reservation(res)
    end

    def reservations_by_date(year:, month:, day:)
      valid_date_entry?(start_year, start_month, start_day)
      date = Date.new(year, month, day)
      date_reservations = []
      @reservations.each do |reservation|
        if reservation.date_range.include?(date)
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
