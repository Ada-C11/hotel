module HotelSystem
  class Room
    attr_reader :number, :price, :status
    attr_accessor :reservations

    def initialize(number)
      @number = number
      @price = 200.00
      @reservations = []
    end

    # def add_reservation(reservation)
    #   @reservations << reservation
    # end

    def date_overlap?(new_start_date, new_end_date)
      @reservations.each do |reservation|
        if new_start_date == reservation.start_date
          return false
        elsif reservation.start_date < new_start_date && new_start_date < reservation.end_date
          return false
        elsif reservation.start_date < new_end_date && new_end_date < reservation.end_date
          return false
        elsif new_start_date > reservation.end_date
          return true
        elsif new_start_date == reservation.end_date
          return true
        elsif new_end_date == reservation.start_date
          return true
        end
      end
    end
  end
end
