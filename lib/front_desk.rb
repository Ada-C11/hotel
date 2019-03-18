require_relative "reservation"
require_relative "block_room"

module Hotel
  class FrontDesk
    # attr_reader :all_rooms, :reservations_record, :block_reservations_only, :reserved_rooms_in_blocks
    attr_accessor :all_rooms, :reservations_record, :block_reservations_only, :reserved_rooms_in_blocks

    def initialize
      @all_rooms = [*(1..20)] # => makes array with elements from 1 to 20

      @reservations_record = Array.new # => stores all reservation objects

      @block_reservations_only = Array.new # Stores all block reservations

      @reserved_rooms_in_blocks = Array.new # stores the reservations of rooms reserved in blocks
    end

    def all_rooms_array
      return @all_rooms
    end

    def reservations_record_array
      return @reservations_record
    end #

    def block_reservations_array
      return @block_reservations_only
    end

    def reserved_rooms_in_blocks_array
      return @reserved_rooms_in_blocks
    end

    def reservation_template(new_booking_ref, new_number_of_rooms, new_first_room_number, new_check_in, new_check_out)
      booking = Hotel::Reservation.new(
        booking_ref: new_booking_ref,
        number_of_rooms: new_number_of_rooms,
        first_room_number: new_first_room_number,
        check_in: new_check_in,
        check_out: new_check_out,
        total_cost: @total_cost,
        room_blocks: @room_blocks,
      )
      return booking
    end

    def make_reservation(new_booking_ref, new_number_of_rooms, new_first_room_number, new_check_in, new_check_out)
      if (@reservations_record.length == 0)
        booking = reservation_template(new_booking_ref, new_number_of_rooms, new_first_room_number, new_check_in, new_check_out)
      else
        for i in (0...@reservations_record.length)
          old_first_room_no = @reservations_record[i].first_room_number
          old_last_room_no = @reservations_record[i].first_room_number + @reservations_record[i].number_of_rooms - 1
          new_last_room_no = new_first_room_number + new_number_of_rooms - 1

          if ((old_first_room_no >= new_first_room_number && old_first_room_no <= new_last_room_no) ||
              (old_last_room_no >= new_first_room_number && old_last_room_no <= new_last_room_no) ||
              ((old_first_room_no <= new_first_room_number) && (old_first_room_no <= new_last_room_no) && (old_last_room_no >= new_first_room_number) && (old_last_room_no >= new_last_room_no)))
            if ((new_check_in >= @reservations_record[i].check_in) && (new_check_in < @reservations_record[i].check_out)) ||
               ((new_check_out >= @reservations_record[i].check_in) && (new_check_out < @reservations_record[i].check_out))
              raise ArgumentError, "No BLOCK 4 U. This room is unavailable."
            else
              booking = reservation_template(new_booking_ref, new_number_of_rooms, new_first_room_number, new_check_in, new_check_out)
            end
          else
            booking = reservation_template(new_booking_ref, new_number_of_rooms, new_first_room_number, new_check_in, new_check_out)
          end
        end
      end
      return booking
    end

    def add_reservation(new_reservation)
      @reservations_record.push(new_reservation)
    end

    def get_reservations_by_date(date)
      reservations_by_date_list = Array.new

      for index in (0...@reservations_record.length)
        if ((@reservations_record[index].check_in <= date) && (@reservations_record[index].check_out > date))
          reservations_by_date_list.push(@reservations_record[index])
        end
      end
      return reservations_by_date_list
    end

    def room_availability(date)
      reservations_at_date = get_reservations_by_date(date)

      available_rooms = Array.new
      for room_idx in (0...@all_rooms.length)
        room_booked = false
        for res_idx in (0...reservations_at_date.length)
          for i in (0..@reservations_record[res_idx].room_blocks.length - 1)
            if (reservations_at_date[res_idx].first_room_number + i == @all_rooms[room_idx])
              room_booked = true
              break
            end
          end
        end
        if (room_booked == false)
          available_rooms << @all_rooms[room_idx]
        end
      end

      return available_rooms
    end

    #### BLOCK METHODS ####
    def add_block_reservations
      for i in (0...@reservations_record.length)
        if (@reservations_record[i].number_of_rooms > 1)
          @block_reservations_only << @reservations_record[i]
        end
      end
    end

    def block_room_reservation_template(block_room_booking_ref, block_room_number, block_check_in, block_check_out)
      block_room_booking = Hotel::BlockRoom.new(
        room_booking_ref: block_room_booking_ref,
        block_room_number: block_room_number,
        check_in: block_check_in,
        check_out: block_check_out,
      )
      return block_room_booking
    end

    def make_reservation_in_block(block_room_booking_ref, block_room_number, block_check_in, block_check_out)
      for i in (0...@block_reservations_only.length)
        if @block_reservations_only[i].room_blocks.include?(block_room_number)
          if ((@block_reservations_only[i].check_in == block_check_in) &&
              (@block_reservations_only[i].check_out == block_check_out))
            block_room_booking = block_room_reservation_template(block_room_booking_ref, block_room_number, block_check_in, block_check_out)
          else
            raise ArgumentError, "Dates must match block dates."
          end
        else
          raise ArgumentError, "This room is not part of any block."
        end
      end
      return block_room_booking
    end

    def add_block_room_reservation(new_reservation)
      @reserved_rooms_in_blocks.push(new_reservation)
    end

    def block_reservations_by_date(date)
      block_reservations_by_date_list = Array.new

      for index in (0...@block_reservations_only.length)
        if ((@block_reservations_only[index].check_in <= date) && (@block_reservations_only[index].check_out > date))
          block_reservations_by_date_list.push(@block_reservations_only[index])
        end
      end
      return block_reservations_by_date_list
    end

    def all_rooms_in_blocks(date)
      block_reservations_at_date = block_reservations_by_date(date)

      rooms_in_blocks = Array.new
      available_rooms_in_block = Array.new
      for i in (0...block_reservations_at_date.length)
        for j in (0...block_reservations_at_date[i].room_blocks.length)
          rooms_in_blocks << block_reservations_at_date[i].room_blocks[j]
        end
      end
      return rooms_in_blocks
    end

    def block_room_availability(date)
      rooms_in_blocks = all_rooms_in_blocks(date)
      rooms_available_in_blocks = Array.new
      for i in (0...rooms_in_blocks.length)
        for j in (0...@reserved_rooms_in_blocks.length)
          if !(@reserved_rooms_in_blocks[j].block_room_number == rooms_in_blocks[i])
            rooms_available_in_blocks << rooms_in_blocks[i]
          end
        end
      end
      return rooms_available_in_blocks
    end
  end
end
