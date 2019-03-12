class Reservation
  attr_accessor

  def initialize(name, room_no, start_date, end_date)
    @name = name
    @room_no = room_no
    @start_date = start_date
    @end_date = end_date
    @total_cost = total_cost
    @reservations = []
  end
end
