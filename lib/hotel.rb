require_relative "room"

module HotelSystem
  class Hotel
    attr_reader :rooms, :reservations

    def initialize
      @rooms = []
      (1..20).each do |num|
        room = HotelSystem::Room.new(num)
        @rooms << room
      end
      @reservations = []
    end

    def find_room(number)
      HotelSystem::Room.valid_room_number(number)
      return @rooms.find { |room| room.room_number == number }
    end

   def reserve_room(start_month: "", start_day: "", start_year: "", num_nights: 0)
    
   end

   def reservation_dates(start_year, start_month, start_day, num_nights)
    dates = []
    start_date = Date.new(start_year,start_month,start_day)
    dates << start_date
    i = 1
    num_nights.times do
        date = start_date + i
        dates << date
        i += 1
    end
    return dates
   end
  
end
end
