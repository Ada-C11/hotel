require 'date'
module Hotel
class DateSpan
  module Error
    class DatePast < StandardError; end
    class RangeInvalid < Standard; end
  end
  def initialize_clone(check_in, check_out)

    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)

  end
end
end