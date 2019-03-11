
class Reservation_Manager
  attr_reader :all_reservations, :rooms

  def initialize(all_reservations: nil)
    @all_reservations = all_reservations || []
    rooms = []
    20.times do
      rooms << {}
    end
    @rooms = rooms
    #will contain array of hashes,
    #each index of array is one room
    #each hash key guest name and hash value is a reservation date
  end

  def make_reservation(reservation)
    all_reservations << reservation
  end
end
