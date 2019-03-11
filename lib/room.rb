class Room
  attr_reader :cost
  attr_accessor :status

  def initialize(room_number, status: :AVAILABLE)
    @cost = 20
    @status = status
  end

  def available?
    status == :AVAILABLE ? true : false
  end
end
