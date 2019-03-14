require "date"
require "pry"

module Hotel
  class Frontdesk
    attr_accessor :rooms, :reservations, :block_reservations

    def initialize
      @rooms = Frontdesk.create_rooms(20)
      @reservations = []
      @block_reservations = {}
    end

    def request_reservation(reservation)
      assign_room_number(reservation)
      @reservations << reservation
      return reservation
    end

    def find_available_rooms(dates)
      available_rooms = []
      @rooms.each do |room|
        overlap = room.availability & dates
        if overlap.length == 0
          available_rooms << room
        end
      end
      return available_rooms
    end

    def assign_room_number(reservation)
      available_rooms = find_available_rooms(reservation.reserved_nights)
      if available_rooms.length == 0
        raise ArgumentError, "There are no available rooms for those dates."
      else
        room_assignment = available_rooms.first
        reservation.room_num = room_assignment.number
        room_assignment.add_reservation(reservation)
      end
    end

    def find_reservation_by_date(date)
      reservations_by_date = @reservations.find_all { |reservation| reservation.reserved_nights.include?(Date.parse(date)) }
      if reservations_by_date.length == 0
        return nil
      else
        return reservations_by_date
      end
    end

    def request_block(reservation, num_of_rooms)
      if num_of_rooms > 5
        raise ArgumentError, "You can reserve a maximum of 5 available rooms in a block"
      end
      available_rooms = find_available_rooms(reservation.reserved_nights)
      if available_rooms.length >= num_of_rooms
        pending_block = []
        i = 1
        num_of_rooms.times do
          index_val = reservation.clone
          pending_block << instance_variable_set("@block_res_#{i}", index_val)
          i += 1
        end
        blocked_rooms = []
        pending_block.each do |room|
          assign_room_number(room)
          blocked_rooms << room
          @reservations << room
        end
        @block_reservations.merge!(reservation.block_reference => blocked_rooms)
      end
      return blocked_rooms
    else
      raise ArgumentError, "There aren't enough rooms available."
    end

    def find_available_block_rooms(block_reference)
      if @block_reservations.has_key?(block_reference)
        available_rooms = []
        @block_reservations.each do |key, value|
          if key == block_reference
            value.each do |block_res|
              if block_res.block_availability == :AVAILABLE
                available_rooms << block_res
              end
            end
          end
        end
        return available_rooms
      else
        raise ArgumentError, "There is no block with that reference id."
      end
    end

    #expects user can see if given block has any rooms available
    #expect that given the right 'password', user can book a blocked room
    #expect that the available rooms in that block decrease by one
    #expect user can only book for those precise block dates

    private

    def self.create_rooms(number_of_rooms)
      room_list = []
      counter = 0
      number_of_rooms.times do
        room = Room.new(counter + 1)
        counter += 1
        room_list << room
      end
      return room_list
    end
  end
end
