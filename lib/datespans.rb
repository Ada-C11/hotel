require 'date'
module Hotel

  class DateSpan

    module Error
      class DatePast < StandardError; end
      class RangeInvalid < Standard; end
    end

  attr_reader :check_in, :check_out

  def initialize(check_in, check_out)

    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)

    raise Error::DatePast unless @check_in > Date.today
    raise Error::RangeInvalid if @check_in > @check_out
    end
  end
end
end