require "date"

class Reservation
  attr_reader :check_in, :check_out

  COST = 200

  def initialize(check_in:, check_out:)
    #maybe save id if we need to pair something later on, probably should delete
    @check_in = check_in
    @check_out = check_out
    raise ArgumentError, "invalid date range, check out must be after check in" if @check_out <= @check_in
    #raise an argument if not date class
    #also probably should raise an argument that it needs to be in the future... but this could be some murakami style hotel

  end

  def cost
    return (@check_out - @check_in).to_i * 200
  end
end
