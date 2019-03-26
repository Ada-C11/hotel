require "time"
require "date"
require_relative "reservation"

module Hotel
  class Block < Reservation
    attr_reader :room_id, :check_in_date, :check_out_date, :nights_stay, :block_name

    attr_accessor :status, :name

    BLOCK_STATUS = [:AVAILABLE, :RESERVED]

    def initialize(input)
      super
      @block_name = input[:block_name]
      @block_reservation_status = :AVAILABLE
    end
  end
end
