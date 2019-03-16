require "date"

module Hotel
  class Reservation
    attr_reader :ckin_date, :ckout_date, :date_range_string_array, :num_nights_of_stay, :base_cost

    def initialize(ckin_date, ckout_date)
      @ckin_date = ckin_date
      @ckout_date = ckout_date
      @date_range_string_array = (ckin_date..ckout_date).map(&:to_s)
      # This creates an array of strings for each date in the range. For example:
      # ['2019-06-11', '2019-06-12', '2019-06-13', '2019-06-14']
      @num_nights_of_stay = (ckout_date - ckin_date)
      # was (date_range_string_array.length - 1)
      # that gave an integer; subtracting (ckout_date - ckin_date)gives a fraction (4/1)
      # same result, not sure of reason for division by 1
      @base_cost = num_nights_of_stay * Room::COST_PER_NIGHT

      raise ArgumentError, "Check out date must be after check in date" if ckin_date >= ckout_date
    end
  end

  def calculate_length_of_stay
  end
end

# ^^^^^ write code here ^^^^^
=begin
start_date = Date.new(2018, 6, 3)
end_date = Date.new(2018, 6, 7)

puts start_date <=> end_date

range = (start_date..end_date).map(&:to_s)
p range

puts Date.parse(range[0])
=end
