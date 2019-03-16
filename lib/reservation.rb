require "date"

module Hotel
  class Reservation
    def initialize
      @ckin_date = ckin_date
      @ckout_date = ckout_date
    end
  end
end

# ^^^^^ write code here ^^^^^

start_date = Date.new(2018, 6, 3)
end_date = Date.new(2018, 6, 7)

puts start_date <=> end_date

range = (start_date..end_date).map(&:to_s)
p range
#   puts day
# end
# range2 = (start_date..end_date).map(&:mday)
# p range2

puts Date.parse(range[0])
