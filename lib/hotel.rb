require "time"

class Hotel
  attr_reader :rooms, :reservations

  def initialize
    @rooms = []
    @reservations = []
  end
end
