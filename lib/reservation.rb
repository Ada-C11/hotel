
# write code here
require "date"
start_date = Date.new(2018, 6, 3)
end_date = Date.new(2018, 6, 7)

puts start_date <=> end_date

range = (start_date..end_date).map(&:to_s)
p range
#   puts day
# end
range2 = (start_date..end_date).map(&:mday)
p range2

puts Date.parse(range[0])
