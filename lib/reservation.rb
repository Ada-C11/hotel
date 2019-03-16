class Reservation
  attr_reader :room_number

  ROOM_PRICE = 200

  #room association, date range
  def initialize(room_number, start_date, end_date)
    @room_number = room_number #integer
    @start_date = start_date #time
    @end_date = end_date #time
  end

  def calculate_total_cost()
    total_nights = @end_date - @start_date #probably convert to integer after test
    total_nights = total_nights.to_i / (24 * 60 * 60)
    ROOM_PRICE * total_nights
  end
end
