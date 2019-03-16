require './spec/spec_helper.rb'
# TODO: EVERYTHING OH THE HUMANITY FIX IT KAAAAATE WHAT HAVE YOU DONE!?
# TODO: DISASTERS!
# TODO: THE HOTEL IS ON FIRE?
# TripAdvisor Rating: 0.000001 star
# There are sharks in the pool.
# Rm. 16 smells like burnt hair
# Ghosts are camping in the elevator.
# No keys. Use a bobby pin.
describe "initialize Registry" do
  before do
    @test_registry = Hotel::Registry.new
  end

  it "is an instance of registry and contains an empty reservations array" do
    expect(@test_registry).must_be_kind_of Hotel::Registry
    expect(@test_registry.reservations).must_be_kind_of Array
  end
end

describe "book_room" do
  before do
    @test_registry = Hotel::Registry.new
    @test_registry.book_room("2019/07/19", "2019/07/25")
    @test_registry.book_room("2019/07/11", "2019/07/14")
  end

  it "reservations array contains all bookings" do
    expect(@test_registry.reservations.length).must_equal(2)
  end

  it "contains the correct object types" do
    @test_registry.reservations.each do |reservation|
      expect(reservation).must_be_instance_of(Hotel::Reservation)
    end
  end

  it "returns empty array when no reservations during dates" do
    expect(@test_registry.concurrences("1066/10/14", "1066/10/15")).empty?(true)
  end

end

describe "Tiny goat outside the hotel" do
    before do
      @test_registry = Hotel::Registry.new
      @test_registry.book_room("2019/07/19", "2019/07/25")
      @test_registry.book_room("2019/07/11", "2019/07/14")
    end

    it 'tiny goat correctly devours records' do
    @test_registry.feed_all_reservations_to_small_goat
    expect(@test_registry.reservations).must_equal []
    end
  end
