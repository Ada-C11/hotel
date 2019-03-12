require 'time'

class DateRange


  # Check the given date is valid or not
  def self.valid_date?(date)
    begin
      Date.parse(date)
      true
    rescue => e
      false
    end
  end

  # Compute the first and last dates according to the params.
  # @return [Array] [Array include first and last date]
  def self.generate_date_range(check_in, check_out)
    (check_in..check_out).select { |d|  valid_date?(d) }
  end

  #p self.generate_date_range("2012-10-27",  "2012-11-03")
end