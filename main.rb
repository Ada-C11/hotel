
require_relative "lib/hotel"
require_relative "lib/room"

def main
  hotel = HotelGroup::Hotel.new

  date_match = /\d{2}\/\d{2}\/\d{4}/

  instructions = ["\n\nChoose an option: ", "1: Print all rooms", "2: View all reservations for a specific date", "3: Get the total cost of a reservation", "4: View the list of available rooms for a specific date", "5: View a list of hotel blocks", "6: Create a reservation", "q: Quit"]
  input = nil
  while input != "q".to_i
    instructions.each do |i|
      puts i
    end

    input = gets.chomp.to_i

    case input
    when 1
      hotel.list_rooms
    when 2
      print "Enter a date (MM/DD/YYYY): "

      input = gets.chomp
      if !input.match(date_match)
        puts "Invalid date entered."
      else
        date_split = input.split("/")
        date_to_find = Date.new(date_split[2].to_i, date_split[0].to_i, date_split[1].to_i)
        reservations = hotel.find_by_date(date_to_find)

        if reservations == []
          puts "No reservations found."
        else
          reservations.each do |res|
            puts res.print_nicely
          end
        end
      end
    when 3
      print "Enter reservation ID: "
      id = gets.chomp.to_i

      res = hotel.find_reservation(id)

      if !res
        puts "Reservation #{id} not found."
      else
        puts res.total_price
      end
    when 4
      print "Enter a start date (MM/DD/YYYY): "

      start_date = gets.chomp
      if !start_date.match(date_match)
        puts "Invalid date entered."
      else
        print "Enter an end date (MM/DD/YYYY): "

        end_date = gets.chomp
        if !end_date.match(date_match)
          puts "Invalid date entered."
        else
          start_date_split = start_date.split("/")
          start_date = Date.new(start_date_split[2].to_i, start_date_split[0].to_i, start_date_split[1].to_i)

          end_date_split = end_date.split("/")
          end_date = Date.new(end_date_split[2].to_i, end_date_split[0].to_i, end_date_split[1].to_i)

          rooms_list = hotel.find_available_rooms(start_date, end_date)

          rooms_list.each do |room|
            puts room.print_nicely
          end
        end
      end
    when "q".to_i
    else
      puts "\nPlease enter a valid choice.\n\n"
    end
  end
end

main
