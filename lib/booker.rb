require_relative "date_range"
require_relative "block"
require "date"

module Hotel
    class Booker
        attr_reader :rooms, :reservations, :blocks

        def initialize(rooms)
            @rooms = rooms
            @reservations = []
            @blocks = []
        end

        def book_room(start_date: ,end_date: )
            range = get_dates(start_date: start_date,end_date: end_date)
            new_reservation = create_reservation(id: reservations.length + 1,date_range: range, room: nil, type: Hotel::Reservation)
            booked_room = find_room(start_date: start_date, end_date: end_date)
            raise ArgumentError, "There are no available rooms for these dates!" if booked_room == nil
            new_reservation.room = booked_room
            add_to_room(room: booked_room, reservation: new_reservation)
            add_to_reservation_list(new_reservation)
            return new_reservation
        end

        def get_dates(start_date:, end_date:)
            range = Hotel::Date_Range.new(start_date: start_date,end_date: end_date).range
            return range
        end

        def create_reservation(id: ,date_range: , room: , type:)
            reservation = type.new(id: id,date_range: date_range ,room: room)
            return reservation
        end

        def find_room(start_date:, end_date: )
            range = get_dates(start_date: start_date, end_date: end_date)
            available_rooms_by_date = range.map{|date| available_rooms(date)}
            potential_rooms = []
            available_rooms_by_date.length.times do |i|
                available_rooms_by_date[0].length.times do |j|
                    if available_rooms_by_date.all?{|array| array.include?(available_rooms_by_date[0][j]) == true } == true
                        potential_rooms.push(available_rooms_by_date[0][j])
                    end
                end
            end

            potential_rooms.length > 0 ? selected_room = potential_rooms[0] : selected_room = nil
            return selected_room
        end

        def add_to_room(room: , reservation: )
            room.add_reservation(reservation)
        end

        def add_to_reservation_list(reservation)
            reservations.push(reservation)
        end

        def view_reservations(date)
            desired_date = Date.iso8601(date.to_s)
            list_by_date = reservations.select{|reservation| reservation.date_range.include?(desired_date) == true}
            return list_by_date
        end

        def available_rooms(date)
            reservations_on_date = view_reservations(date)
            rooms_of_reservations = reservations_on_date.map{|reservation| reservation.room}
            list_available_rooms = rooms.reject{|room| rooms_of_reservations.include?(room) == true}
            return list_available_rooms
        end

        def create_block(start_date: , end_date:, rooms:, cost:)
            range = get_dates(start_date: start_date, end_date: end_date)

            raise ArgumentError, "A block can have no more than 5 rooms!" if rooms.length > 5 

            rooms.each do |room|
                range.each do |date|
                    raise ArgumentError, "Those rooms are not available for those dates!" if room.available?(date) == false
                end
            end

            block_reservations = []

            rooms.each do |room|
                new_reservation = create_reservation(id: reservations.length + 1,date_range: range, room: room, type: Hotel::Block_Reservation)
                new_reservation.cost = cost
                add_to_room(room: room, reservation: new_reservation)
                add_to_reservation_list(new_reservation)
                block_reservations.push(new_reservation)
            end

            new_block = Hotel::Block.new(id: blocks.length + 1, block_reservations: block_reservations)
            blocks.push(new_block)

            return new_block
        end

        def reserve_room_in_block(block:, block_reservation:)
            status = block.reserve_block_room(block_reservation)
            raise ArgumentError, "This room is already reserved!" if status == false
        end

        def view_available_rooms_in_block(block)
            list = block.list_available_rooms
            raise ArgumentError, "There are no available rooms in this block!" if list == []
            return list
        end

    end
end