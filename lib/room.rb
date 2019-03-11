module Hotel

  class Room 
    attr_reader :id, :price

    def initialize id: nil, price: nil
      valid_id(id)
      @id = id
      @price = price
    end

    def self.all
      CSV.read('support/rooms.csv', headers: true, header_converters: :symbol, converters: :numeric).map do |line| 
        Room.new(id: line[0].to_i, price: line[1].to_f)
      end
    end

    def valid_id(id)
      unless id.instance_of?(Integer) && id > 0 && id <= 20
        raise ArgumentError, "ID must be a positive number, given #{id}..."
      end
    end
    private 

    # def self.from_csv(record)
    #   return new(
    #            id: record[:id],
    #            price: record[:price]
    #          )
    # end


  end
end