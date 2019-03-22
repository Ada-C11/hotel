require "time"

class Date_Range 
    def self.valid_date?(date)
        begin
            Date.parse(date)
            true
        rescue => exception
            false
        end 
    end

    def self.new_date_range(check_in_date, check_out_date)
    end
end
