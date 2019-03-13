module Hotel
  class Room
    attr_reader :rate, :number
    attr_accessor :booked_nights

    def initialize(room_number:)
      @rate = 200
      @number = room_number
      @booked_nights = []
    end

    def available?(date:)
      booked_nights.include?(date) ? false : true
    end
  end
end
