module Hotel
    class Room
        attr_reader :id

        attr_accessor :reservations

        def initialize(id)
            @id = id
            @reservations = []
        end

        def available?(date)
            desired_date = Date.iso8601(date.to_s)
            return status
        end

    end
end