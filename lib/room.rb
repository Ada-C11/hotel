class Room
  attr_reader :id, :bookings
  
  def initialize(id)
    @id = id
    @bookings = Array.new
  end

  def reserve(time_interval)
    @bookings << time_interval
  end

  def overlap?(time_interval)
    if @bookings.empty?
      return false
    end

    @bookings.each do |booking|
      return booking.overlap?(time_interval)
    end
  end
end