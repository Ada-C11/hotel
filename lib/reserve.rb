require 'date'
module Hotel
  class Reservation
    attr_reader :id, :start_date, :end_date, :room_booked

    def initialize id:nil, start_date:, end_date:
      @id = id
      @start_date = check_in
      @end_date = end_date
      @room_booked = room_booked
      @reservations = []
    end

    def add_reservation(reserve)
      @reservations << reserve
    end

    private
    # def self.all
    #   CSV.read().map do |line|
    #     Reservation.new(line[0].to_i, line[1], line[2], line[3].to_i)
    #   end
    # end
  end
end