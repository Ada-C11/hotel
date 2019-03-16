module HotelSystem
  class Room
    attr_reader :number, :price, :status, :block_id
    attr_accessor :reservations

    def initialize(number:, status: :NOT_BLOCKED, block_id: nil)
      @number = number
      @price = 200.00
      @reservations = []
      @status = status.to_sym
      @block_id = block_id
    end

    def date_available?(possible_start_date, possible_end_date)
      @reservations.each do |reservation|
        if possible_start_date == reservation.start_date
          return false
        elsif reservation.start_date < possible_start_date && possible_start_date < reservation.end_date
          return false
        elsif reservation.start_date < possible_end_date && possible_end_date < reservation.end_date
          return false
        elsif possible_start_date < reservation.start_date && possible_end_date == reservation.end_date
          return false
        elsif possible_start_date < reservation.start_date && reservation.end_date < possible_end_date
          return false
        elsif reservation.end_date < possible_start_date
          return true
        elsif possible_start_date < reservation.start_date && possible_end_date < reservation.start_date
          return true
        elsif possible_start_date == reservation.end_date
          return true
        elsif possible_end_date == reservation.start_date
          return true
        end
      end
    end
  end
end