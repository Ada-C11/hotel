require 'date'

class DateRange
  attr_reader :date

  def initialize(date: nil)
    date = valid_date?(date)

    @date = date
  end

  def date_range_valid?(check_in, check_out) 
    if check_out < check_in
      raise ArgumentError, "Check out date cannot occur before check in date"
    end

    # unless check_in > Date.parse(DateTime.now)
    #   raise ArgumentError, "Cannot use past dates, given #{check_in}"
    # end
  end

  def self.dates_ovelap?(date1, date2)
    #TBD used in conjunction with Room.bookings
  end

  def valid_date?(date_str)
    format = "%Y-%m-%d"
    date_str = Date.parse(date_str).to_s
    date_str = Date.strptime(date_str,format).to_s
    begin
      Date.parse(date_str)
    rescue ArgumentError => exception
      puts "Invalid date, given#{date_str}"
    end
  end

end