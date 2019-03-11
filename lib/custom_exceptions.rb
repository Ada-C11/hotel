class InvalidDateRangeError < StandardError
  def initialize(msg = "Start date must be in the present and before end date.")
    super
  end
end
