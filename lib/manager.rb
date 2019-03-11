# Require gems

# Require relatives
require_relative "room.rb"

module Hotel
  class Manager
    attr_reader :rooms

    def initialize
      @rooms = (1..20).map do |room_number|
      end
    end
  end
end
