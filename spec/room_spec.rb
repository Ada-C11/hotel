require_relative "spec_helper"

describe "Room Class" do
  describe "Room initializer" do
    before do
      @room = Room.new(
        id: 1,
      )
    end
    it "is an instance of Room" do
      expect(@room).must_be_kind_of Room
    end

    #   it "has a default vacancy of :VACANT" do
    #     expect(Room.new(id: 3).status).must_equal :VACANT
    #   end

    #   expect(@room.id).must_be_kind_of Integer
    #   expect(@room.status).must_be_kind_of Symbol
    # end

    # describe "add_trip method" do
    #   before do
    #     pass = Passenger.new(
    #       id: 1,
    #       name: "Test Passenger",
    #       phone_number: "412-432-7640",
    #     )
    #     @driver = Room.new(
    #       id: 3,
    #       name: "Test Driver",
    #       vin: "12345678912345678",
    #     )
    #     @trip = Room.new(
    #       id: 8,
    #       driver: @driver,
    #       passenger: pass,
    #       start_time: "2016-08-08",
    #       end_time: "2018-08-09",
    #       rating: 5,
    #     )
    #   end

    #   it "adds the room" do
    #     expect(@room.rooms).wont_include @room
    #     previous = @room.rooms.length

    #     @room.add_room(@room)

    #     expect(@room.rooms).must_include @room
    #     expect(@room.rooms.length).must_equal previous + 1
    #   end
  end
end
