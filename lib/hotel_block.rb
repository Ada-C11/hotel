require "pry"
require "date"

class Hotel_Block
  attr_reader :check_in, :check_out
  attr_accessor :rooms

  def initialize(check_in, check_out, rooms)
    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)

    if rooms < 5
      raise ArgumentError, "Block must be no greater than 5 rooms. The input was #{rooms}"
    end
    @rooms = rooms
  end

  def date_range(check_in, check_out)
    range = (@check_in...@check_out).to_a
    return range
  end
end
