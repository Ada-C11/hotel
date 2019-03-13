module Hotel
  class Room
    attr_reader :rate, :number
    attr_accessor :booked_nights

    def initialize(room_number:)
      @rate = 200
      @number = room_number
      @booked_nights = []
    end

    def available?(night: nil, range: nil)
      if range
        range.each do |night|
          return false if booked_nights.include?(night)
        end

        return true
      elsif night
        return booked_nights.include?(night) ? false : true
      end
    end
  end
end
