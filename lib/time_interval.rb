require 'time'
require 'date'

class Time_Interval
  attr_reader :check_in, :check_out

  def initialize(check_in, check_out)
    check_in = Date.parse(check_in)
    check_out = Date.parse(check_out)

    if check_in > check_out
      raise ArgumentError.new("Check out time cannot be greater than check in time")
    end

    if check_in.to_time < Time.now || check_out.to_time < Time.now
      raise ArgumentError.new("Check in and check out time cannot be in the past")
    end

    @check_in = check_in
    @check_out = check_out
  end

  def self.overlap?(interval_one, interval_two)
    if interval_one.check_in < interval_two.check_in && interval_one.check_out >= interval_two.check_in
      return true
    end
      
    if interval_one.check_in > interval_two.check_in && interval_one.check_in <= interval_two.check_out
      return true
    end

    return false
  end
end