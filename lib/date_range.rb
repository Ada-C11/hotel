require_relative "reservation_booker"
require 'date'

module Hotel
    class DateRange
      def self.valid_checkin_dates?(check_in_year, check_in_month, check_in_day)
        is_valid = true
        if !Date.valid_date?(check_in_year.to_i, check_in_month.to_i, check_in_day.to_i) 
            is_valid = false
        end
        return is_valid
        end

        def self.valid_checkout_dates?(check_out_year, check_out_month, check_out_day)
            is_valid = true
            if !Date.valid_date?(check_out_year.to_i, check_out_month.to_i, check_out_day.to_i)
                is_valid = false
            end
            return is_valid
        end

        def self.check_in_date(check_in_year, check_in_month, check_in_day)
            check_in_date_integers = check_in_year.to_s + "/" + check_in_month.to_s + "/" + check_in_day.to_s
            check_in_date = Date.parse(check_in_date_integers)
            return check_in_date
        end

        def self.check_out_date(check_out_year, check_out_month, check_out_day)
            check_out_date_integers = check_out_year.to_s + "/" + check_out_month.to_s + "/" + check_out_day.to_s
            check_out_date = Date.parse(check_out_date_integers)
            return check_out_date
        end

      def self.valid_dates?(check_in_date, check_out_date)
        is_valid = true
        if check_in_date >= check_out_date
            is_valid = false
        end
        return is_valid
      end

 
      def self.date_range(check_in_date, check_out_date)
        reservation_date_range = (check_in_date...check_out_date).to_a
        return reservation_date_range
      end

      def self.within_range(check_in_date, check_out_date, check_date)
        date_range = Hotel::DateRange.date_range(check_in_date, check_out_date)
        return date_range.include?(check_date) 
      end

    end 
  end  