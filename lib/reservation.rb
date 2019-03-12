module Hotel
  class Reservation
    attr_reader :checkin, :checkout
    def initialize(checkin, checkout)
      @checkin = checkin
      @checkout = checkout 
      @room = nil
    end
  end
end
