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
      @num_nights_of_stay = (ckout_date - ckin_date).to_i
      @base_cost = num_nights_of_stay * Room::COST_PER_NIGHT

      raise ArgumentError, "Check out date must be after check in date." if ckin_date >= ckout_date
    end
  end

  # def self.calculate_length_of_stay
  # THIS IS DONE IN INSTANTIATION; MOVE TO HERE?
  #   nights = (ckout_date - ckin_date).to_i
  #   return nights
  # end
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
