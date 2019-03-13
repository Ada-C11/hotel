require "pry"
require "date"

class Hotel_Block
  attr_reader :check_in, :check_out
  attr_accessor :rooms

  def initialize(check_in, check_out, rooms)
    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)
    @rooms = rooms
  end
end
