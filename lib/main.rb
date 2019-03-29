require_relative "reservation_manager"
require "table_print"

def main
  reservation_manager = Hotel::ReservationManager.new
  puts "Welcome to Hotel Reservation System!"
  loop do
    puts "What would you like to do next?"
    puts "[access all rooms] [access available rooms] [access reservations] [reserve a room] [create a block] [check rooms in a block] [reserve from block] [total cost] [quit]"
    print ">"

    user_input = gets.chomp

    case user_input.downcase
    when "access all rooms"
      tp reservation_manager.rooms
    when "access available rooms"
      print "Enter check_in_date: "
      check_in_date = gets.chomp
      print "Enter check_out_date: "
      check_out_date = gets.chomp
      tp reservation_manager.find_available_rooms(check_in_date: check_in_date, check_out_date: check_out_date)
    when "access reservations"
      print "Enter date: "
      input = gets.chomp
      tp reservation_manager.list_reservations(date: input)
    when "reserve a room"
      print "Enter room id: "
      room_id = gets.chomp.to_i
      print "Enter check_in_date: "
      check_in_date = gets.chomp
      print "Enter check_out_date: "
      check_out_date = gets.chomp
      puts "You have reserved the room below:"
      tp reservation_manager.reserve(room_id: room_id, check_in_date: check_in_date, check_out_date: check_out_date)
    when "create a block"
      print "How many rooms would you like to block?"
      puts "> "
      num_rooms = gets.chomp.to_i
      room_ids = []
      num_rooms.times do
        print "Enter room id: "
        room_id = gets.chomp.to_i
        room_ids << room_id
      end
      print "Enter check_in_date: "
      check_in_date = gets.chomp
      print "Enter check_out_date: "
      check_out_date = gets.chomp
      print "Enter discount rate: "
      discount_rate = gets.chomp.to_f
      tp reservation_manager.create_block(room_ids: room_ids, check_in_date: check_in_date, check_out_date: check_out_date, discount_rate: discount_rate)
    when "check rooms in a block"
      print "Enter block id: "
      block_id = gets.chomp.to_i
      puts reservation_manager.check_available_rooms_in_blocks(block_id: block_id)
    when "reserve from block"
      print "Enter room id: "
      room_id = gets.chomp.to_i
      print "Enter block id: "
      block_id = gets.chomp.to_i
      tp reservation_manager.reserve_from_block(room_id: room_id, block_id: block_id)
    when "total cost"
      print "Enter reservation id: "
      reservation_id = gets.chomp.to_i
      puts reservation_manager.total_cost(reservation_id: reservation_id)
    when "quit"
      break
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
