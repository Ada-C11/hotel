require 'time'

class Time_Interval
  attr_reader :check_in, :check_out

  # Everytime we initalize an object interval, we need to use begin/rescue block
  def initialize(check_in, check_out)
    if check_in !~ /\d{4}-\d{2}-\d{2}/ || check_out !~ /\d{4}-\d{2}-\d{2}/
      raise ArgumentError.new("Invalid date format")
    end

    if check_in > check_out
      raise ArgumentError.new("Check out time cannot be greater than check in time")
    end

    check_in = process_date(check_in)
    check_out = process_date(check_out)

    @check_in = check_in
    @check_out = check_out
  end

  private
  def process_date(date, format="%Y-%m-%d")
    begin
      return Date.strptime(date)
    rescue ArgumentError => e
      puts e
    end
  end
end