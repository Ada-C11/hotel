require_relative 'room'
require_relative 'reservation'

module HotelSystem
  class Hotel
    attr_reader :rooms
    attr_accessor :reservations

    def initialize
      @rooms = Array(1..20)
      @reservations = []
    end

    def make_reservation
    end
  end
end