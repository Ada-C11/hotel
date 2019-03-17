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
    end # initialize

    def all_rooms_array
      return @all_rooms
    end # all_rooms_array

    def reservations_record_array
      return @reservations_record
    end # reservations_record_array

    def block_reservations_array
      return @block_reservations_only
    end # block_reservations_array

    def reserved_rooms_in_blocks_array
      return @reserved_rooms_in_blocks
    end # reserved_rooms_in_blocks_array

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
        puts "\n\nAPPLE"
        booking = reservation_template(new_booking_ref, new_number_of_rooms, new_first_room_number, new_check_in, new_check_out)
      else
        puts "\n\nBANANA"
        for i in (0...@reservations_record.length)
          old_first_room_no = @reservations_record[i].first_room_number
          old_last_room_no = @reservations_record[i].first_room_number + @reservations_record[i].number_of_rooms - 1
          new_last_room_no = new_first_room_number + new_number_of_rooms - 1

          if ((old_first_room_no >= new_first_room_number && old_first_room_no <= new_last_room_no) ||
              (old_last_room_no >= new_first_room_number && old_last_room_no <= new_last_room_no) ||
              ((old_first_room_no <= new_first_room_number) && (old_first_room_no <= new_last_room_no) && (old_last_room_no >= new_first_room_number) && (old_last_room_no >= new_last_room_no)))
            puts "\n\nORANGE"
            # if (@reservations_record[i].room_blocks.include?(new_first_room_number))
            if ((new_check_in >= @reservations_record[i].check_in) && (new_check_in < @reservations_record[i].check_out)) ||
               ((new_check_out >= @reservations_record[i].check_in) && (new_check_out < @reservations_record[i].check_out))
              raise ArgumentError, "No BLOCK 4 U. This room is unavailable."
              puts "\n\nKIWI"
            else
              puts "\n\nCHERRY"
              booking = reservation_template(new_booking_ref, new_number_of_rooms, new_first_room_number, new_check_in, new_check_out)
            end # third if
          else
            puts "\n\nPOTATO"
            booking = reservation_template(new_booking_ref, new_number_of_rooms, new_first_room_number, new_check_in, new_check_out)
          end # second if
        end # for end
      end # first it
      return booking
    end # method end

    def add_reservation(new_reservation)
      @reservations_record.push(new_reservation)
    end # add_reservation

    def get_reservations_by_date(date)
      reservations_by_date_list = Array.new

      for index in (0...@reservations_record.length)
        if ((@reservations_record[index].check_in <= date) && (@reservations_record[index].check_out > date))
          reservations_by_date_list.push(@reservations_record[index])
        end # if
      end # for
      return reservations_by_date_list
    end # get_reservations_by_date

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
            end # if
          end # for
        end # for
        if (room_booked == false)
          available_rooms << @all_rooms[room_idx]
        end # if
      end # for

      return available_rooms
    end # room_availability

    #### BLOCK METHODS ####
    def add_block_reservations
      for i in (0...@reservations_record.length)
        if (@reservations_record[i].number_of_rooms > 1)
          @block_reservations_only << @reservations_record[i]
        end # if
      end # for
    end # method

    def block_room_reservation_template(block_room_booking_ref, block_room_number, block_check_in, block_check_out)
      puts "\n\nBLOCKROOM"
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
        puts "\n\n#{i}"
        if @block_reservations_only[i].room_blocks.include?(block_room_number)
          puts "\n\nABANDON SHIP"
          if ((@block_reservations_only[i].check_in == block_check_in) &&
              (@block_reservations_only[i].check_out == block_check_out))
            puts "\n\nshark tank"
            block_room_booking = block_room_reservation_template(block_room_booking_ref, block_room_number, block_check_in, block_check_out)
          else
            raise ArgumentError, "Dates must match block dates."
          end # inner if
        else
          raise ArgumentError, "This room is not part of any block."
        end # outer if
      end # outer for
      return block_room_booking
    end # method

    def add_block_room_reservation(new_reservation)
      @reserved_rooms_in_blocks.push(new_reservation)
    end # add_block_room_reservation

    def block_reservations_by_date(date)
      block_reservations_by_date_list = Array.new

      for index in (0...@block_reservations_only.length)
        if ((@block_reservations_only[index].check_in <= date) && (@block_reservations_only[index].check_out > date))
          block_reservations_by_date_list.push(@block_reservations_only[index])
        end # if
      end # for
      return block_reservations_by_date_list
    end # method

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
    end # method

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
    end # method
  end # class
end # module

# @concierge = Hotel::FrontDesk.new

# new_booking = @concierge.make_reservation(
#   1001,
#   4,
#   5,
#   Date.new(2019, 5, 23),
#   Date.new(2019, 5, 25)
# )
# @concierge.add_reservation(new_booking)
# @concierge.add_block_reservations

# puts "\nBOOKING 1"
# puts "Memory address: #{new_booking}"
# puts "Number of rooms: #{new_booking.number_of_rooms}"
# puts "Room number: #{new_booking.first_room_number}"
# puts "Check_in: #{new_booking.check_in}"
# puts "Check_out: #{new_booking.check_out}"
# puts "Total cost: #{new_booking.total_cost}"
# puts "Room blocks: #{new_booking.room_blocks}"

# new_booking_2 = @concierge.make_reservation(
#   1002,
#   5,
#   10,
#   Date.new(2019, 5, 23),
#   Date.new(2019, 5, 28)
# )
# @concierge.add_reservation(new_booking_2)
# @concierge.add_block_reservations

# puts "\nBOOKING 2"
# puts "Memory address: #{new_booking_2}"
# puts "Number of rooms: #{new_booking_2.number_of_rooms}"
# puts "Room number: #{new_booking_2.first_room_number}"
# puts "Check_in: #{new_booking_2.check_in}"
# puts "Check_out: #{new_booking_2.check_out}"
# puts "Total cost: #{new_booking_2.total_cost}"
# puts "Room blocks: #{new_booking_2.room_blocks}"

# new_booking_3 = @concierge.make_reservation(
#   1003,
#   3,
#   14,
#   Date.new(2019, 4, 18),
#   Date.new(2019, 4, 21)
# )
# @concierge.add_reservation(new_booking_3)
# puts "\nBOOKING 3"
# puts "Memory address: #{new_booking_3}"
# puts "Number of rooms: #{new_booking_3.number_of_rooms}"
# puts "Room number: #{new_booking_3.first_room_number}"
# puts "Check_in: #{new_booking_3.check_in}"
# puts "Check_out: #{new_booking_3.check_out}"
# puts "Total cost: #{new_booking_3.total_cost}"
# puts "Room blocks: #{new_booking_3.room_blocks}"

# new_booking_4 = @concierge.make_reservation(
#   1004,
#   1,
#   20,
#   Date.new(2019, 4, 18),
#   Date.new(2019, 4, 21)
# )
# @concierge.add_reservation(new_booking_4)
# puts "\nBOOKING 4"
# puts "Memory address: #{new_booking_4}"
# puts "Number of rooms: #{new_booking_4.number_of_rooms}"
# puts "Room number: #{new_booking_4.first_room_number}"
# puts "Check_in: #{new_booking_4.check_in}"
# puts "Check_out: #{new_booking_4.check_out}"
# puts "Total cost: #{new_booking_4.total_cost}"
# puts "Room blocks: #{new_booking_4.room_blocks}"
# @concierge.add_block_reservations(new_booking_4)

# new_booking_5 = @concierge.make_reservation_in_block(
#   2000,
#   6,
#   Date.new(2019, 5, 23),
#   Date.new(2019, 5, 25)
# )
# @concierge.add_block_room_reservation(new_booking_5)
# @concierge.add_block_room_reservation(new_booking_5)
# @concierge.add_block_reservations

# puts "\nBOOKING 5"
# puts "Memory address: #{new_booking_5}"
# puts "Room number: #{new_booking_5.block_room_number}"
# puts "Check_in: #{new_booking_5.check_in}"
# puts "Check_out: #{new_booking_5.check_out}"

# new_booking_6 = @concierge.make_reservation(
#   1201,
#   5,
#   1,
#   Date.new(2019, 3, 20),
#   Date.new(2019, 3, 24)
# )
# @concierge.add_reservation(new_booking_6)

# puts "\nBOOKING 6"
# puts "Memory address: #{new_booking_6}"
# puts "Number of rooms: #{new_booking_6.number_of_rooms}"
# puts "Room number: #{new_booking_6.first_room_number}"
# puts "Check_in: #{new_booking_6.check_in}"
# puts "Check_out: #{new_booking_6.check_out}"
# puts "Total cost: #{new_booking_6.total_cost}"
# puts "Room blocks: #{new_booking_6.room_blocks}"

# @concierge.add_block_reservations

# block_reserved_rooms = @concierge.reserved_rooms_in_blocks_array
# puts "Reserved Rooms: #{block_reserved_rooms}"

# room_availibility = @concierge.block_room_availability(Date.new(2019, 3, 23))
# puts "Rooms available in blocks: #{room_availibility}"
# reservations_array = @concierge.reservations_record_array
# reservation_list_date = @concierge.get_reservations_by_date(Date.new(2019, 3, 20))
# avail_rooms = @concierge.room_availability(Date.new(2019, 3, 23))

# block_reservations = @concierge.block_reservations_array
# block_reservation_list = @concierge.block_reservations_by_date(Date.new(2019, 3, 23))
# block_rooms_avail = @concierge.block_room_availability(Date.new(2019, 3, 21))

# puts "\nReservations array length: #{reservations_array.length}"
# puts "\nReservations by date list: #{reservation_list_date}"
# puts "\nReservations by date: #{reservation_list_date.length}"
# puts "\nAvailable Rooms: #{avail_rooms}"

# puts "\nBlock Reservations array length: #{block_reservations.length}"
# puts "\nReservations by date list: #{block_reservation_list}"
# puts "\nReservations by date: #{block_reservation_list.length}"
# puts "\nAvailable Rooms: #{block_rooms_avail}"
