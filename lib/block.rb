
module Hotel
  class Block
    attr_reader :block_id, :room_ids, :check_in_date, :check_out_date, :discount_rate
    attr_accessor :rooms_info

    def initialize(block_id:, room_ids:, check_in_date:, check_out_date:, discount_rate:)
      @block_id = block_id
      @rooms_info = {}
      room_ids.each do |room_id|
        @rooms_info[room_id] = :AVAILABLE
      end
      @room_ids = room_ids
      @check_in_date = Date.parse(check_in_date)
      # raise ArgumentError, "check_in_date is required" if check_in_date == nil

      @check_out_date = Date.parse(check_out_date)
      # @check_out_date = Date.parse(check_out_date)
      # raise ArgumentError, "check_out_date is required" if check_out_date == nil
      @discount_rate = discount_rate
      raise ArgumentError, "Maximum number of room_ids is 5!" if room_ids.length > 5
      # raise ArgumentError, "block_id is required" if block_id == nil
      # raise ArgumentError, "at least 1 room is required" if room_ids == nil
      # raise ArgumentError, "check_in_date is required" if check_in_date == nil
      # raise ArgumentError, "check_out_date is required" if check_out_date == nil
      # raise ArgumentError, "discount_rate is required" if discount_rate == nil
    end

    def self.load_all
      @blocks = []
    end
  end
end
