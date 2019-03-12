class ReservationManager
  attr_reader :rooms, :reservations

  def initialize
    @rooms = (1..20).map { |num| Room.new(number: num) }
    @reservations = []
  end

  # def find_by_date(date)
  # end
end
