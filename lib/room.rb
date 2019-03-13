require_relative "../spec/spec_helper"

module Hotel
  class Room
    attr_reader :id, :cost_per_day, :unavailable_list

    def initialize(id:, cost_per_day:, unavailable_list: nil)
      @id = id
      @cost_per_day = cost_per_day
      @unavailable_list ||= []
    end

    def room_available?(check_in:, check_out:)
      unavailable_list.each do |unavailable|
        return false if unavaiable_dates.include?(check_in) || unavaiable_dates.include?(check_out)
      end
      return true
    end

    def unavailable_dates
      return unavailable.date_range
    end
  end
end
