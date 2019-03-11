
class Room
  attr_reader :status

  def initialize(room_number, status: :available)
    @room_number = room_number
    @status = status.to_sym
  end

  #   def available?
  #     availabe_rooms = [*(1..20)]
  #   end
end
