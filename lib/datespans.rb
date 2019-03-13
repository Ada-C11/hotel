module Hotel
  class DateSpan
    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)

      raise ArgumentError, 'Check-in date past.' unless @check_in > Date.today
      raise ArgumentError, 'Reverse in/out dates.' unless @check_in < @check_out
    end

    def stay_length
      stay_length = (check_out - check_in).to_i
      stay_length
    end

    def span
      [*@check_in...@check_out]
    end

    def overlaps?(existing_span)
      !(existing_span.span & span).empty?
    end
  end
end