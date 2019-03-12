module Hotel

  class Room 
    ROOM_RATE = 200.00
    attr_reader :id, :price

    def initialize id: nil
      valid_id(id)
      @id = id
      @price = ROOM_RATE
    end

    def self.all
      CSV.read('support/rooms.csv', headers: true, header_converters: :symbol, converters: :numeric).map do |line| 
        Room.new(id: line[0].to_i)
      end
    end

    def valid_id(id)
      unless id.instance_of?(Integer) && id > 0 && id <= 20
        raise ArgumentError, "ID must be a positive number, given #{id}..."
      end
    end

    private 
    #incase i need anything to be private
  end
end