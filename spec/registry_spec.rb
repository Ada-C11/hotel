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
    (1..4).each do |room|
      @test_registry.reservations << Hotel::Reservation.new("2019/07/19", "2019/07/25", room)
    end
  end

  it "accurately reports array of registrations given a single date string" do
    expect @test_registry.concurrences("2019/07/21").must_be_instance_of(Array)
    expect @test_registry.concurrences("2019/07/21")[1].must_be_instance_of(Hotel::Reservation)
    expect @test_registry.concurrences("2019/07/20").count.must_equal(4)
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
    before = (5..19).each do |room|
      @test_registry.reservations << Hotel::Reservation.new("2019/07/19", "2019/07/25", room)
    end
    @test_registry.available?("2019/07/19", "2019/07/25")
    after = @test_registry.okay_rooms
    expect(before).wont_equal(after)
    expect(after).must_equal([20])
  end
end

describe "list_available method lists all available rooms on a day" do
  before do
    @test_registry = Hotel::Registry.new
    (1..10).each do |room|
      @test_registry.reservations << Hotel::Reservation.new("2019/07/19", "2019/07/25", room)
    end
    @test_registry.available?("2019/07/23")
  end

  it "returns an array" do
    expect(@test_registry.okay_rooms).must_be_instance_of(Array)
  end

  it "contains the correct number of rooms" do
    expect(@test_registry.okay_rooms.length).must_equal(10)
  end

  it "doesn't have unavailable rooms" do
    expect(@test_registry.okay_rooms.include?(2)).must_equal(false)
  end

  it "does list available rooms" do
    expect(@test_registry.okay_rooms.include?(18)).must_equal(true)
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
