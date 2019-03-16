require './spec/spec_helper.rb'
require 'pry'

describe "initialize Registry" do
  before do
    @test_registry = Hotel::Registry.new
  end

  it "is an instance of registry and contains an empty reservations array" do
    expect(@test_registry).must_be_kind_of Hotel::Registry
    expect(@test_registry.reservations).must_be_kind_of Array
  end
end

describe "concurrences method" do
  before do
    @test_registry = Hotel::Registry.new
  end

  it "returns empty array when no reservations during dates" do
    expect(@test_registry.concurrences("1066/10/14", "1066/10/15").empty?).must_equal(true)
  end
end

describe "available? method" do
  before do
    r1 = Hotel::Reservation.new("2019/07/19", "2019/07/25", 1)
    r2 = Hotel::Reservation.new("2019/07/19", "2019/07/25", 2)
    r3 = Hotel::Reservation.new("2019/07/19", "2019/07/25", 3)
    r4 = Hotel::Reservation.new("2019/07/19", "2019/07/25", 4)
    @test_registry = Hotel::Registry.new
    @test_registry.reservations.push(r1, r2, r3, r4)
  end

  it "returns false if okay_rooms array is empty" do
    (5..20).each do |room|
      @test_registry.reservations << Hotel::Reservation.new("2019/07/19", "2019/07/25", room)
    end
    expect(@test_registry.available?("2019/07/19", "2019/07/25")).must_equal(false)
  end

  it "returns true if okay_rooms array is not empty" do
    expect(@test_registry.available?("2019/07/19", "2019/07/25")).must_equal(true)
  end

  it "pushes available room numbers to okay_rooms array" do
    before = @test_registry.okay_rooms.length
    (5..19).each do |room|
      @test_registry.reservations << Hotel::Reservation.new("2019/07/19", "2019/07/25", room)
    end
    @test_registry.available?("2019/07/19", "2019/07/25")
    after = @test_registry.okay_rooms.length
    expect(before).wont_equal(after)
    expect(@test_registry.okay_rooms).must_equal([20])
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
end
