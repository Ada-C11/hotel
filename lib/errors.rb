module Errors
  class BookingConflict < StandardError; end
  class ValidationError < StandardError; end
  class ReverseDates < StandardError; end
  class NotThatKindaHotelPal < StandardError; end
end
