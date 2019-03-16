require "date"

module Hotel
  class Reservation
    attr_reader :ckin_date, :ckout_date

    def initialize(ckin_date, ckout_date)
      @ckin_date = ckin_date
      @ckout_date = ckout_date

      begin
        compare_dates = ckin_date <=> ckout_date
      rescue
        raise Exception if ckin_date >= ckout_date
      end
    end
  end
end

# ^^^^^ write code here ^^^^^

# start_date = Date.new(2018, 6, 3)
# end_date = Date.new(2018, 6, 7)

# puts start_date <=> end_date

# range = (start_date..end_date).map(&:to_s)
# p range

# puts Date.parse(range[0])
