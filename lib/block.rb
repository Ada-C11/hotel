module Hotel
  class Block
    attr_reader :id, :start_date, :end_date, :collection_rooms, :discounted_rate

    def initialize(id:, start_date:, end_date:, collection_rooms:, discounted_rate: nil)
      #   super(id, start_date, end_date)
      @id = id
      @start_date = start_date
      @end_date = end_date
      @collection_rooms = collection_rooms
      @discounted_rate = discounted_rate
    end

  end
end
