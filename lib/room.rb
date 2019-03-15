module Hotel
  class Room
    attr_reader :rate, :number
    attr_accessor :booked_nights

    def initialize(room_number:)
      @rate = 200
      @number = room_number
      @booked_nights = []
    end

    def available?(night: nil, nights: nil)
      if nights
        nights.each { |n| return false if booked_nights.include?(n) }
        return true
      elsif night
        return booked_nights.include?(night) ? false : true
      end
    end

    def book(nights:)
      booked_nights.concat(nights)
    end
  end
end
