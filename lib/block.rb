require_relative "unavailable"

module Hotel
  class Block < Unavailable
    attr_reader :percent_discount, :number_available

    def initialize(check_in:, check_out:, percent_discount:)
      super(check_in: check_in, check_out: check_out)
      @percent_discount = percent_discount
      @number_available = nil
    end

    # Can only set once.
    def set_number_available(count)
      @number_available = count unless @number_available
    end

    def decrease_number_available
      @number_available -= 1 unless @number_available == 0
    end

    def has_room_available_for_reservation?
      return @number_available > 0
    end

    private

    # Override
    def generate_confirmation_id(prefix: "B")
      return prefix + self.class.confirmation_number_generator.to_s
    end
  end
end
