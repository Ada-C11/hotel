require 'time'

class Time_Interval
  attr_reader :check_in, :check_out
  DATE_FORMAT = "%Y-%m-%d"

  def initialize(check_in, check_out)
    if check_in !~ /\d{4}-\d{2}-\d{2}/ || check_out !~ /\d{4}-\d{2}-\d{2}/
      raise ArgumentError.new("Invalid date format")
    end

    @check_in = check_in
    @check_out = check_out
  end

  def process_date(date, format)
    begin
      return date = Date.strptime(date, DATE_FORMAT)
    rescue ArgumentError => e
      puts e
    end
  end
end