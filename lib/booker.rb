require "csv"
require "date"
require 'time'

require_relative "room"
require_relative "reserve"


module Hotel
  class Bookings
    attr_reader :rooms, :reservations

    def initialize(directory: "./support")
      # @rooms = Room.load_all(directory: directory)
      # @reservations = Reserve.load_all(directory: directory)
     
      # completed_reservations
    end

    def completed_reservations
     # @reservations is an array of all reservations made
    end

  
  end
end