class ReservationManager
  attr_reader :rooms, :reservations

  def initialize
    @rooms = (1..20).map { |num| Room.new(number: num) }
    @reservations = []
  end

  def request_reservation(check_in_date, check_out_date)
    reservation = Reservation.new(
      check_in_date: check_in_date,
      check_out_date: check_out_date,
      room_number: rand(1..20),
    )

    @reservations << reservation
  end

  # def add_reservation(reservation)
  #   @reservations << reservation
  # end

  # def find_by_date(date)
  #   @reservations
  # end
end
