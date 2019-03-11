class Room
  attr_reader :number, :rate, :reservations

  def initialize(number:, rate: 200, reservations: [])
    @number = number
    @rate = rate
    @reservations = reservations
  end
end
