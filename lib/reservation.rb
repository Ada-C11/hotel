module Hotel
  class Reservation
    def initialize(room_number, in_date, out_date)
      @room_number = room_number
      @in_date = in_date
      @out_date = out_date
    end

    # user type; block is for primary person who makes reservation block

    def reservation_block(name, block_of_rooms, in_date, out_date)
    end

    # create blocks
    # validate blocks
    # validate users (name)
    # calculate total cost
    # reserve the blocks
  end
end
