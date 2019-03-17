require_relative "reservation"

module Hotel
  class Room
    attr_reader :id, :cost_per_night, :unavailable_list

    def initialize(id:, cost_per_night:, unavailable_list: nil)
      @id = id
      @cost_per_night = cost_per_night
      @unavailable_list ||= []
    end

    def available_for_date_range?(date_range:)
      return date_range.all? do |date|
               available?(date: date)
             end
    end

    def available?(date:)
      unavailable_list.each do |unavailable|
        return false if unavailable.date_unavailable?(date: date)
      end
      return true
    end

    def reservation?(date:)
      unavailable_list.each do |unavailable|
        return true if unavailable.date_unavailable?(date: date) && unavailable.id[0] == "R"
      end
      return false
    end
  end
end
