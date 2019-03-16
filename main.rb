
require_relative "lib/hotel"
require_relative "lib/room"

def main
  hotel = HotelGroup::Hotel.new

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
      match = /\d{2}\/\d{2}\/\d{4}/
      input = gets.chomp
      if !input.match(match)
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
      print "Enter a date (MM/DD/YYYY): "
      match = /\d{2}\/\d{2}\/\d{4}/
      input = gets.chomp
      if !input.match(match)
        puts "Invalid date entered."
      else
        puts "nice work"
      end
    when "q".to_i
    else
      puts "\nPlease enter a valid choice.\n\n"
    end
  end
end

main
