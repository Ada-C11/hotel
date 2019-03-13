module Hotel
  class Room
    attr_reader :rate, :number
    attr_accessor :booked_dates

    def initialize(room_number:)
      @rate = 200
      @number = room_number
      @booked_dates = []
    end

    def available?(date:)
      booked_dates.include?(date) ? false : true
    end
  end
end
