require "room_factory.rb"
require "datespans.rb"

module Hotel
  class Reservation
    attr_reader :rm_id, :total, :check_in, :check_out

    def initialize(**input)
      @room = ""
      @date_range = DateRanges.new(input[:check_in], input[:check_out])
      @total = COST * @date_range.span
    end
  end
end
