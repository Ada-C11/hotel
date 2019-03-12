class DateRange
  attr_reader :date

  def initialize(date: nil)
    date = valid_date?(date)

    @date = date
  end

  def date_range_valid?(check_in, check_out) 
    unless check_in < check_out
      raise ArgumentError, "Check out date cannot occur before check in date"
    end
  end

  def self.dates_ovelap?(date1, date2)
    
  end

  def valid_date?(date_str)
    format = "%Y-%m-%d"
    date_str = Date.parse(date_str).to_s
    date_str = Date.strptime(date_str,format).to_s
    begin
      Date.parse(date_str)
    rescue ArgumentError => exception
      puts "Invalid date given #{date_str} need: YYYY-MM-DD"
    end
  end

end