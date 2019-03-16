require_relative "reservation"

module Hotel
  class Room
    attr_reader :id, :cost_per_night, :unavailable_list

    def initialize(id:, cost_per_night:, unavailable_list: nil)
      @id = id
      @cost_per_night = cost_per_night
      @unavailable_list ||= []
    end

    def room_available?(date:)
      unavailable_list.each do |unavailable|
        return false if unavailable.date_unavailable?(date: date)
      end
      return true
    end
  end
end
