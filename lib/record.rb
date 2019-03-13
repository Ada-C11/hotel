
module Hotel
  class Record
    attr_reader :id

    def initialize(id)
      self.class.validate_id(id)
      @id = id
    end

    def self.load_all
      raise NotImplementedError, "Implement me in a class"
    end

    def self.validate_id(id)
      if id.nil? || id <= 0 || id > 20
        raise ArgumentError, "ID cannot be blank, less than zero or larger than 20."
      end
    end
  end
end
