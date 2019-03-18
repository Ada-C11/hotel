require_relative "room"
require_relative "reservation"
require_relative "date_range"
require_relative "hotel_block"
require "date"

module HotelSystem
  class Hotel
    attr_reader :rooms, :blocks
    attr_accessor :reservations

    def initialize(number_of_rooms)
      @rooms = []
      add_rooms(number_of_rooms)
      @reservations = []
      @blocks = []
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

    def create_date_range(start_year:, start_month:, start_day:, num_nights: nil)
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
      res_date = Date.new(year, month, day)
      if res_room.reservations == []
        return false
      end
      res_room.reservations.each do |res|
        if res.date_range.overlap?(res_date)
          return true
        end
      end
      return false
    end 

    def find_available_room(start_year:, start_month:, start_day:)
      valid_date_entry?(start_year, start_month, start_day)
      @rooms.each do |hotel_room|
        reserved = room_reserved?(room_number: hotel_room.room_number, year: start_year, month: start_month, day: start_day)
        block_status = hotel_room.in_block?(year: start_year, month: start_month, day: start_day)
        if !reserved && !block_status
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
      res_dates = create_date_range(start_year: start_year, start_month: start_month, start_day: start_day, num_nights: num_nights)
      # res_dates_range = res_dates.date_list
      res_room = find_available_room(start_year: start_year, start_month: start_month, start_day: start_day)
      id = create_reservation_id
      res = HotelSystem::Reservation.new(id: id, room: res_room, date_range: res_dates)
      @reservations << res
      res_room.add_reservation(res)
    end

    def reservations_by_date(year:, month:, day:)
      valid_date_entry?(year, month, day)
      date = Date.new(year, month, day)
      date_reservations = []
      @reservations.each do |reservation|
        if reservation.date_range.overlap?(date)
          date_reservations << reservation
        end
      end
      if date_reservations.length == 0
        puts "There are no reservations for that date."
        return nil
      else
        return date_reservations   
      end
    end

    def available_rooms_by_date(year:, month:, day:)
      valid_date_entry?(year, month, day)
      available_rooms = []
      @rooms.each do |room|
        status = room_reserved?(room_number: room.room_number, year: year, month: month, day: day)
        if status == false
          available_rooms << room
        end
      end
      if available_rooms.length == 0
        puts "There are no available rooms for that date."
        return nil
      else
        return available_rooms 
      end 
    end

    def create_block(start_year:, start_month:, start_day:, num_nights:, room_nums:, block_rate:)
      valid_date_entry?(start_year, start_month, start_day)
      block_dates = create_date_range(start_year: start_year, start_month: start_month, start_day: start_day, num_nights: num_nights)
      if room_nums.class != Array
        raise ArgumentError, "Please enter an array of room numbers for room_nums, even if it has only one room number."
      end
      block_rooms = room_nums.map { |num| find_room(num)}
      block_rooms.each do |room|
        room.reservations.each do |reservation|
          overlap = reservation.date_range.overlap?(block_dates)
          if overlap == true
            raise NotImplementedError, "Block can't be created, room #{room.room_number} is already booked during those dates."
          end
        end
        room.block_date_ranges.each do |block_date_ranges| 
          overlap = block_date_ranges.overlap?(block_dates)
          if overlap == true
            raise NotImplementedError, "Block can't be created, room #{room.room_number} is already in a block during those dates."
          end
        end
        room.add_block_date_ranges(block_dates)
      end
      block_id = create_block_id
      block = HotelSystem::HotelBlock.new(id: block_id, date_range: block_dates, rooms: block_rooms, room_rate: block_rate)
      @blocks << block
    end

    def create_block_id
      if @blocks.length == nil
        return 1
      else
        id = @blocks.length + 1
        return id
      end
    end

    def find_block(num)
      return @blocks.find { |block| block.id == num }
    end

    def reserve_block_room(room_num:, block_id:)
      room = find_room(room_num)
      block = find_block(block_id)
      if block.available_rooms.include?(room)
        res_id = create_reservation_id
        block_res = HotelSystem::Reservation.new(id: res_id, room: room, room_number: room_num, date_range: block.date_range, nightly_rate: block.room_rate)
        @reservations << block_res
        room.reservations << block_res
        block.available_rooms.delete(room)
      else
        raise NotImplementedError, "Sorry, that room is not available or is not a part of that block."
      end
    end

  end
end
