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

      it "rooms contains 20 elements" do
        expect(rooms.length).must_equal 20
      end

      it "each element is a struct with :cost_per_night and :id" do
        rooms.each do |room|
          expect(room).must_respond_to :cost_per_night
          expect(room).must_respond_to :id
          expect(room).must_respond_to :unavailable_list
        end
      end
    end
  end
  describe "Manifest#list_rooms" do
    it "returns a string" do
      expect(manifest.list_rooms).must_be_instance_of String
    end

    it "returns an empty string if rooms to list is empty array" do
      expect(manifest.list_rooms(rooms_to_list: [])).must_equal ""
    end

    it "raises ArgumentError if passed non array object" do
      expect {
        manifest.list_rooms(rooms_to_list: nil)
      }.must_raise ArgumentError
    end

    it "formats string" do
      expect(manifest.list_rooms).must_equal "Room number 1
Room number 2
Room number 3
Room number 4
Room number 5
Room number 6
Room number 7
Room number 8
Room number 9
Room number 10
Room number 11
Room number 12
Room number 13
Room number 14
Room number 15
Room number 16
Room number 17
Room number 18
Room number 19
Room number 20
"
    end
  end
  describe "Manifest#list_unavailable_rooms_by_date" do
    before do
      booker = Hotel::Booker.new
      @manifest_unavailable = booker.manifest
      @day1 = Time.now.to_date + 3
      @day2 = @day1 + 4
      room_ids = [2, 10, 12]
      room_ids.each do |id|
        room = @manifest_unavailable.find_room(id)
        booker.book_room(Hotel::Reservation.new(check_in: @day1.to_s, check_out: @day2.to_s), room)
      end
    end
    it "returns a string" do
      expect(@manifest_unavailable.list_unavailable_rooms_by_date(@day1)).must_be_instance_of String
    end

    it "formats string and correctly selects unavailable rooms" do
      expect(@manifest_unavailable.list_unavailable_rooms_by_date(@day1 + 1)).must_equal "Room number 2\nRoom number 10\nRoom number 12\n"
    end

    it "returns an empty string if no rooms reserved for given date" do
      expect(@manifest_unavailable.list_unavailable_rooms_by_date(@day2 + 5)).must_equal ""
    end
  end
end
