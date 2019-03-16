require_relative "spec_helper"

describe "Manifest" do
  let(:manifest) { Hotel::Manifest.new }
  describe "Manifest#initialize" do
    it "is an instance of Manifest" do
      expect(manifest).must_be_instance_of Hotel::Manifest
    end

    let(:rooms) { manifest.rooms }
    describe "Check attributes of Manifest" do
      it "instance variable rooms is an array" do
        expect(rooms).must_be_instance_of Array
      end

      it "each element is a type of room" do
        rooms.each do |room|
          expect(room).must_be_instance_of Hotel::Room
        end
      end
    end
  end
  describe "Manifest#add_rooms_to_rooms" do
  end

  describe "Manifest#find_room" do
    it "will return room" do
      expect(manifest.find_room(id: 3)).must_be_instance_of Hotel::Room
    end

    it "return correct room if room is in rooms" do
      expect(manifest.find_room(id: 3)).must_equal manifest.rooms[2]
    end

    it "returns nil if room is not in rooms" do
      expect(manifest.find_room(id: manifest.rooms.length + 3)).must_be_nil
    end
  end

  describe "Manifest#list_rooms" do
    it "returns an array" do
      expect(manifest.list_rooms).must_be_instance_of Array
    end

    it "returns [] if rooms to list is empty array" do
      expect(manifest.list_rooms(rooms_to_list: [])).must_equal []
    end

    it "returns an array of all the rooms" do
      expect(manifest.list_rooms).must_equal manifest.rooms
    end
  end

  describe "Manifest#list_unavailable_rooms_by_date" do
    before do
      booker = Hotel::Booker.new
      @manifest_unavailable = booker.manifest
      @day1 = Time.now.to_date + 3
      @day2 = @day1 + 4
      @room_ids = [2, 10, 12]
      @room_ids.each do |id|
        room = @manifest_unavailable.find_room(id: id)
        booker.book_room(Hotel::Reservation.new(check_in: @day1, check_out: @day2), room)
      end
    end
    it "returns an Array" do
      expect(@manifest_unavailable.list_unavailable_rooms_by_date(date: @day1)).must_be_instance_of Array
    end

    it "correctly selects unavailable rooms" do
      comparable_rooms = @room_ids.map do |id|
        @manifest_unavailable.find_room(id: id)
      end
      expect(@manifest_unavailable.list_unavailable_rooms_by_date(date: @day1 + 1)).must_equal comparable_rooms
    end

    it "returns an empty Array if no rooms reserved for given date" do
      expect(@manifest_unavailable.list_unavailable_rooms_by_date(date: @day2 + 5)).must_equal []
    end
  end
end
