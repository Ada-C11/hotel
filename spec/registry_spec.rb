require './spec/spec_helper.rb'
# TODO: EVERYTHING OH THE HUMANITY FIX IT KAAAAATE WHAT HAVE YOU DONE!?
# TODO: DISASTERS!
# TODO: THE HOTEL IS ON FIRE?
# TripAdvisor Rating: 0.000001 star
# There are sharks in the pool.
# Rm. 16 smells like burnt hair
describe "initialize Registry" do
  before do
    @test_registry = Hotel::Registry.new
    @test_registry.registrations = []
  end

  it "is an instance of registry and contains an empty reservations array" do
    expect(@test_registry).must_be_kind_of Hotel::Registry
    expect(@test_registry.reservations).must_be_kind_of Array
  end

  describe "reserve_room" do
    before do
    @test_registry = Hotel::Registry.new
      Hotel::Registry.reserve_room("7/19/2019", 4)
      Hotel::Registry.reserve_room("7/24/2019", 2)
    end

    it "reservations array contains all bookings" do
      expect(@test_reservations.size).must_equal 2
    end

    it "returns empty array if no reservations during date" do
      expect(@test_registry.find_by_date(Date.parse("1066.10.14"))).must_equal([])
    end

    it "contains the correct object types"
    @test_reservations.each do |reservation|
      expect(reservation).must_be_instance_of(Hotel::Reservation)
    end

    describe "TinyGoat"
    it 'clears all records from reservations array'
    @test_registry.TinyGoat::Goat.feed_all_records_to_small_goat
    expect(@test_reservations).must_equal []
  end
end
