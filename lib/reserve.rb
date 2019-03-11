require 'date'
module Hotel
  class Reservation
    attr_reader :id, :check_in, :check_out, :number_of_rooms

    def initialize id:nil, check_in:, check_out:, number_of_rooms: nil
      @id = id
      @check_in = check_in
      @check_out = check_out
      number_of_rooms = number_of_rooms
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