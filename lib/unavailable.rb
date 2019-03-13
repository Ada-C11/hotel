module Hotel
  class Unavailable
    attr_reader :check_in, :check_out, :id
    @@confirmation_number = 123000

    def initialize(check_in:, check_out:)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      unless valid_date_range?(@check_in, @check_out)
        raise InvalidDateRangeError.new()
      end
      @id = generate_confirmation_id
    end

    def valid_date_range?(check_in, check_out)
      return check_in < check_out && check_in >= Time.new.to_date
    end

    def duration_in_days
      return (check_out - check_in)
    end

    def date_range
      return (check_in...check_out)
    end

    private

    def generate_confirmation_id(prefix = "R")
      return "#{prefix}#{self.class.confirmation_number_generator}"
    end

    def self.confirmation_number_generator
      @@confirmation_number += 1
    end
  end
end
