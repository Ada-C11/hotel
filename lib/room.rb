class Room
  attr_reader :id, :price

  def initialize(id)
    @id = id
    @price = 200
    @reservations = []
  end

  def self.add_reservation
    @reservations << reservation
  end
end
