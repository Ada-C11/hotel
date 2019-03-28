require "date"

module Hotel
    class Date_Range
        attr_reader :start_date, :end_date, :range

        def initialize(start_date: , end_date: )
            @start_date = Date.iso8601(start_date.to_s)
            @end_date = Date.iso8601(end_date.to_s)
            raise ArgumentError, "Please enter a valid date!" if @start_date > @end_date
            range = (@start_date .. @end_date).to_a
            range.pop
            @range = range
        end

    end
end