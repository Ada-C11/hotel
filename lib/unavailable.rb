module Hotel
  # Abstract class, not intended to be intiated.
  class Unavailable
    attr_reader :check_in, :check_out, :id
    @@confirmation_number = 123000

    def initialize(check_in:, check_out:)
      @check_in = check_in
      @check_out = check_out
      unless valid_unavailable_dates?(check_in: @check_in, check_out: @check_out)
        raise InvalidDateRangeError.new()
      end
      @id = generate_confirmation_id
    end

    def valid_unavailable_dates?(check_in:, check_out:)
      return check_in < check_out && check_in >= Time.new.to_date
    end

    def duration_in_days
      return (check_out - check_in)
    end

    def date_range
      return (check_in...check_out)
    end

    def date_unavailable?(date:)
      return date_range.include?(date)
    end

    private

    def generate_confirmation_id(prefix: "")
      return prefix + self.class.confirmation_number_generator.to_s
    end

    def self.confirmation_number_generator
      @@confirmation_number += 1
    end
  end
end
