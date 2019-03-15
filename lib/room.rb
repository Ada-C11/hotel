class Room
  attr_reader :id, :price, :reservations

  def initialize(id)
    @id = id
    @price = 200
    @reservations = []
  end

  def self.add_reservation
    @reservations << reservation.date_range
  end
  def self.is_available?(start_date, end_date)
    (start_date...ende_date).each do |date|
      if @reservations.flat.include?(date)
        return false
      end
    end
    return true
  end
end
