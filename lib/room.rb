
class Room
  attr_reader :id, :reservation, :rooms, :dates

  def initialize(id:)
    @id = id
    @dates = []
  end
end
