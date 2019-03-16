require_relative "reservation.rb"

module Hotel
  class BlockRoom
    # attr_reader :
    DISCOUNT_RATE = 175

    def initialize(block_rm_nums, check_in, check_out)
      @block_rm_nums = []
      @check_in = check_in
      @check_out = check_out
    end
  end
end
