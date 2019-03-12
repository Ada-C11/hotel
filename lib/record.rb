module Hotel
  class Record
    attr_reader :id

    def initialize(id)
      self.class.validate_id(id)
      @id = id
    end

    def self.all_rooms
      @all_rooms = []
      20.times do |id|
        room = {
          :id => id + 1,
          :cost => 200.0,
          :status => :AVAILABLE,
          :reservation => [],
        }
        @all_rooms << room
      end
      return @all_rooms
    end

    def self.validate_id(id)
      if id.nil? || id <= 0 || id > 20
        raise ArgumentError, "ID cannot be blank, less than zero or larger than 20."
      end
    end
  end
end
