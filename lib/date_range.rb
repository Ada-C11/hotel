class DateRange
  attr_reader :check_in, :check_out

  def initialize(check_in: nil, check_out: nil)
    check_in = valid_date?(check_in)
    check_out = valid_date?(check_out)
    date_range_valid?(check_in, check_out)

    @check_in = check_in
    @check_out = check_out
  end

  def date_range_valid?(check_in, check_out) 
    unless check_in < check_out
      raise ArgumentError, "Check out date cannot occur before check in date"
    end
  end
  
end