require "date"

module Hotel
    class Date_Range
        attr_reader :start_date, :end_date, :range

        def initialize(start_date: , end_date: )
            @start_date = Date.iso8601(start_date.to_s)
            @end_date = Date.iso8601(end_date.to_s)
            # if Date.valid_date?(@start_date) == false || Date.valid_date?(@end_date) == false
            #     raise ArgumentError, "Please enter a valid date!" 
            # end
            raise ArgumentError, "Please enter a valid date!" if @start_date > @end_date
            @range = fill_range
        end

        private

        def fill_range
            difference = (@end_date - @start_date).to_i
            range = []
            i = 0
            while i < difference
                range.push(@start_date + i)
                i += 1
            end
            return range
        end

    end
end