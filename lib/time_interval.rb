require 'time'
require 'date'

class Time_Interval
  attr_reader :check_in, :check_out

  def initialize(check_in, check_out)
    check_in = Date.parse(check_in)
    check_out = Date.parse(check_out)

    if check_in >= check_out
      raise ArgumentError.new("Check in time cannot be greater than or equal to check out time")
    end

    @check_in = check_in
    @check_out = check_out
  end

  def overlap?(time_interval)
    # There is an overlap? method in Ruby API. But I wrote this to practice thinking about the logic
    if @check_in <= time_interval.check_in && @check_out > time_interval.check_in
      return true
    end
      
    if @check_in >= time_interval.check_in && @check_in < time_interval.check_out
      return true
    end

    return false
  end
end