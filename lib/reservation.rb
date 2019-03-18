module Hotel
  class Reservation
    attr_reader :name, :room_id, :check_in_date, :check_out_date, :nights_stay

    def initialize(input)
      check_in_date = input[:check_in_date]
      check_out_date = input[:check_out_date]
      @name = input[:name]
      @room_id = input[:room_id]
      @check_in_date = input[:check_in_date]
      @check_out_date = input[:check_out_date]
      # will use helper method for the below
      # @nights_stay = nights_stay
    end
  end
end
