module Hotel
  class Room
    attr_reader :number, :cost, :reservations

    def initialize(number, cost)
      @number = number
      @cost = cost
      @reservations = []
    end


    def add_reservation(reservation)
      @reservations << reservation
    end
  


    def available_on_these_dates?(check_in_date, check_out_date)
      dates = Hotel::DateRange.date_range(check_in_date, check_out_date)
      available = true
      @reservations.each do |reservation|
        dates.each do |date|
        if Hotel::DateRange.within_range(reservation.check_in_date, reservation.check_out_date, date) == true
          available = false
        end
        end
      end
      return available
    end

  end
    
end
   