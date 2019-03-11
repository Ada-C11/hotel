module Hotel
  class Room
    attr_reader :number
    attr_accessor :availability #, :status

    def initialize(number)
      @number = number
      @availability = []
      #@status = []
    end

    def self.all_rooms
      room_list = []
      counter = 0
      20.times do
        room = Room.new(counter + 1)
        counter += 1
        room_list << room
      end
      return room_list
    end

    def add_reservation(checkin_date, checkout_date)
      booked = [checkin_date, checkout_date]
      @availability << booked
    end
  end
end
