
module Hotel
  class Block
    attr_reader :block_id, :room_ids, :check_in_date, :check_out_date

    def initialize(block_id:, room_ids: nil, check_in_date: nil, check_out_date: nil, discount_rate: nil)
      @block_id = block_id
      @room_ids = room_ids
      #   @room_ids = []
      @check_in_date = check_in_date
      @check_out_date = check_out_date
      @discount_rate = discount_rate
      raise ArgumentError, "Maximum number of rooms is 5!" if room_ids.length > 5
      raise ArgumentError, "block_id is required" if block_id == nil
      raise ArgumentError, "at least 1 room_id is required" if room_ids == nil
      raise ArgumentError, "check_in_date is required" if check_in_date == nil
      raise ArgumentError, "check_out_date is required" if check_out_date == nil
      raise ArgumentError, "discount_rate is required" if discount_rate == nil
    end

    def self.load_all
      @blocks = []
    end
  end
end
