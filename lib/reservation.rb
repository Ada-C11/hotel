module Hotel
  class Reservation
    def self.all
      10.times.map do
        Hotel::Reservation.new
      end
    end
  end
end
