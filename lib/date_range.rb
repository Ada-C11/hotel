require_relative "reservation_booker"
require 'date'

module Hotel
    class DateRange

      def self.valid_dates?(check_in_date, check_out_date)
        is_valid = true
        if !Date.valid_date?(check_in_date) || !Date.valid_date?(check_out_date) || check_in_date >= check_out_date
            is_valid = false
        end
        return is_valid
      end
      def self.date_range(check_in_date, check_out_date)
        reservation_date_range = (check_in_date...check_out_date).to_a
        return reservation_date_range
      end

      def self.within_range(start_date, end_date, check_date)
        date_range = Hotel::DateRange.date_range(start_date, end_date)
        return date_range.include?(check_date) 
      end

    end
  end