require_relative "reservation"
require_relative "block_room"

module Hotel
  class FrontDesk
    attr_reader :all_rooms, :reservations_record, :block_reservations_only, :reserved_rooms_in_blocks

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
        # total_cost: @total_cost,
        # room_blocks: @room_blocks,
      )
      return booking
    end

    def room_overlap?(old_first_room_no, new_first_room_number, new_last_room_no, old_last_room_no)
      if ((old_first_room_no >= new_first_room_number && old_first_room_no <=     new_last_room_no) ||
        (old_last_room_no >= new_first_room_number && old_last_room_no <= new_last_room_no) || ((old_first_room_no <= new_first_room_number) && (old_first_room_no <= new_last_room_no) && (old_last_room_no >= new_first_room_number) && (old_last_room_no >= new_last_room_no)))
        return true
      else
        return false
      end
    end

    def date_overlap?(new_check_in, old_check_in, old_check_out, new_check_out)
      if ((new_check_in >= old_check_in) && (new_check_in < old_check_out)) ||
               ((new_check_out >= i.check_in) && (new_check_out < i.check_out))
              raise ArgumentError, "No BLOCK 4 U. This room is unavailable."
      else
        return false
      end
    end

    def make_reservation(new_booking_ref, new_number_of_rooms, new_first_room_number, new_check_in, new_check_out)
      if (@reservations_record.length == 0)
        booking = reservation_template(new_booking_ref, new_number_of_rooms, new_first_room_number, new_check_in, new_check_out)
      else
        @reservations_record.each do |i|
          old_first_room_no = i.first_room_number
          old_last_room_no = i.first_room_number + i.number_of_rooms - 1
          new_last_room_no = new_first_room_number + new_number_of_rooms - 1

          if room_overlap?(old_first_room_no, new_first_room_number, new_last_room_no, old_last_room_no) == true
            if date_overlap?(new_check_in, i.check_in, i.check_out, new_check_out) == false
              booking = reservation_template(new_booking_ref, new_number_of_rooms, new_first_room_number, new_check_in, new_check_out)
            end
          else # room_overlap == false
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
      @reservations_record.each do |element| 
        if element.check_in <= date && element.check_out > date
          reservations_by_date_list << element
        end
      end
      return reservations_by_date_list
    end

    def room_availability(date)
      reservations_at_date = get_reservations_by_date(date)

      available_rooms = Array.new

      @all_rooms.each do |room|
        room_booked = false
        reservations_at_date.each do |res|
          for i in (0...res.room_blocks.length)
            if (res.first_room_number + i == room)
              room_booked = true
              break
            end
          end
        end
        if (room_booked == false)
          available_rooms << room
        end
      end

      return available_rooms
    end

    #### BLOCK METHODS ####
    def add_block_reservations
      @reservations_record.each do |element|
        if element.number_of_rooms > 1
          @block_reservations_only << element
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
      booking_in_block = ""
      @block_reservations_only.each do |element| 
        if element.room_blocks.include?(block_room_number) 
          if (element.check_in == block_check_in) && (element.check_out == block_check_out)
            booking_in_block = block_room_reservation_template(block_room_booking_ref, block_room_number, block_check_in, block_check_out)
          else
            raise ArgumentError, "Dates must match block dates."
          end
        else
          raise ArgumentError, "This room is not part of any block."
        end
      end
      return booking_in_block
    end

    def add_block_room_reservation(new_reservation)
      @reserved_rooms_in_blocks.push(new_reservation)
    end

    def block_reservations_by_date(date)
      block_reservations_by_date_list = Array.new
      @block_reservations_only.each do |block_element| 
        if block_element.check_in <= date && block_element.check_out > date
          block_reservations_by_date_list << block_element
        end
      end
      return block_reservations_by_date_list
    end

    def all_rooms_in_blocks(date)
      block_reservations_at_date = block_reservations_by_date(date)

      rooms_in_blocks = Array.new
      available_rooms_in_block = Array.new

      block_reservations_at_date.each do |i|
        i.room_blocks.each do |j|
          rooms_in_blocks << j
        end
      end
      return rooms_in_blocks
    end

    def block_room_availability(date)
      rooms_in_blocks = all_rooms_in_blocks(date)
      rooms_available_in_blocks = Array.new

      rooms_in_blocks.each do |i|
        @reserved_rooms_in_blocks.each do |j|
          if !(j.block_room_number == i)
            rooms_available_in_blocks << i
          end
        end
      end
      return rooms_available_in_blocks
    end
  end
end
