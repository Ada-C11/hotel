require_relative "unavailable"

module Hotel
  class Block < Unavailable
    attr_reader :percent_discount

    def initialize(check_in:, check_out:, percent_discount:)
      super(check_in: check_in, check_out: check_out)
      @percent_discount = percent_discount
    end

    private

    #Override
    def generate_confirmation_id(prefix: "B")
      return prefix + self.class.confirmation_number_generator.to_s
    end
  end
end
