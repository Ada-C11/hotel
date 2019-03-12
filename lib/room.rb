module Hotel
    class Room
        attr_reader :id

        attr_accessor :reservations

        def initialize(id)
            @id = id
            @reservations = []
        end

        def available?(date)
        end

    end
end