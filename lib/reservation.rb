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
      @num_nights_of_stay = calculate_length_of_stay(ckin_date, ckout_date)
      @base_cost = calculate_cost

      raise ArgumentError, "Check out date must be after check in date." if ckin_date >= ckout_date
    end

    def calculate_length_of_stay(ckin_date, ckout_date)
      # THIS IS DONE IN INSTANTIATION; MOVE TO HERE?
      nights = (ckout_date - ckin_date).to_i
      return nights
    end

    def calculate_cost
      num_nights_of_stay * Room::COST_PER_NIGHT
    end

    def self.res_include_date(res, date)
      res.date_range_string_array.include? (date.to_s)
    end
    def self.date_range_as_strings(res)
      (res.date_range_string_array.first + " through " + res.date_range_string_array.last)
    end

    def self.ck_dates_are_available(res_array_to_check, ckin, ckout)
      # Given an array of reservation objects, determine if any of them overlap with a requested range (ckin - ckout)
      # Return true if the requested dates are free (there are no conflicts), otherwise return false
      res_first = res_array_to_check[0]
      res_last = res_array_to_check[-1]

      if res_array_to_check.length == 0
        return true
      elsif res_array_to_check.length == 1
        (res_first.ckout_date <= ckin) || (ckout <= res_first.ckin_date) ? true : false
      else # there is more than one reservation in the array
        # check left and right ends of the reservation array
        return true if (ckout <= res_first.ckin_date)
        return true if (res_last.ckout_date <= ckin)
        # check date gaps between reservations
        i = 0
        while i <= res_array_to_check.length - 2
          res_a = res_array_to_check[i]
          res_b = res_array_to_check[i + 1]

          if (res_a.ckout_date <= ckin) && (ckout <= res_b.ckin_date)
            return true
          end

          i += 1
        end
        return false
      end
    end
  end
end

# ^^^^^ write code here ^^^^^
# notes for working with the Date class
=begin
start_date = Date.new(2018, 6, 3)
end_date = Date.new(2018, 6, 7)

puts start_date <=> end_date

range = (start_date..end_date).map(&:to_s)
p range

puts Date.parse(range[0])
=end
