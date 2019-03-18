require "date"

class Reservation
  attr_reader :check_in, :check_out, :room, :block
  attr_accessor :block_room_status

  COST = 200
  #discount actually means after discount, for example. 20% off would be .8 (100-20)

  def initialize(check_in:, check_out:, room: nil, block: nil, block_room_status: :AVAILABLE, discount: 1.0)
    raise ArgumentError, "must pass in a Date object" if check_in.instance_of?(Date) == false
    @check_in = check_in
    @check_out = check_out
    raise ArgumentError, "invalid date range, check out must be after check in" if @check_out <= @check_in
    @room = room
    @block = block
    status_options = [:AVAILABLE, :UNAVAILABLE]
    raise ArgumentError, "invalid status" if status_options.include?(block_room_status) == false
    @block_room_status = block_room_status
    @discount = discount
  end

  def cost
    return (@check_out - @check_in).to_i * (200 * @discount)
  end
end
