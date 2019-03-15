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
  end

  it "is an instance of registry and contains an empty reservations array" do
    expect(@test_registry).must_be_kind_of Hotel::Registry
    expect(@test_registry.reservations).must_be_kind_of Array
  end

  describe "reserve_room" do
    before do
      @test_registry = Hotel::Registry.new
      @test_registry.reserve_room("2019/07/19", 4)
      @test_registry.reserve_room("2019/07/19", 2)
    end

    it "reservations array contains all bookings" do
      expect(@test_reservations.length).must_equal(2)
    end

    it "returns empty array if no reservations during date" do
      expect(@test_registry.find_by_date(Date.parse("1066.10.14"))).must_equal([])
    end

    it "contains the correct object types" do
      @test_registry.reservations.each do |reservation|
        expect(reservation).must_be_instance_of(Hotel::Reservation)
      end
    end
  end
end

describe "tiny_goat" do
  it 'clears all records from reservations array' do
    @test_registry.tiny_goat.feed_all_records_to_small_goat(@reservations)
    expect(@test_registry.reservations).must_equal []
  end
end
