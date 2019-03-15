class Reservation
  attr_reader :room_number

  @room_price = 200

  #room association, date range
  def initialize(room_number, start_date, end_date)
    @room_number = room_number #integer
    @start_date = start_date #time
    @end_date = end_date #time
  end

  def calculate_total_cost()
    total_nights = @end_date - @start_date - 1 #probably convert to integer after test
    @room_price * total_nights
  end
end
