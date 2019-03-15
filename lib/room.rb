require_relative "hotel"
require_relative "reservation"

class Room
  attr_reader :id, :price, :reservations

  def initialize(id)
    @id = id
    @price = 200
    @reservations = []
  end
end
