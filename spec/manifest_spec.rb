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

      it "each element is a struct with :cost_per_day and :id" do
        rooms.each do |room|
          expect(room).must_respond_to :cost_per_day
          expect(room).must_respond_to :id
          expect(room).must_respond_to :unavailable
        end
      end
    end
  end
  describe "Manifest#list_rooms" do
    it "returns a string" do
      expect(manifest.list_rooms).must_be_instance_of String
    end

    it "formats string" do
      expect(manifest.list_rooms(2)).must_equal "Room number 1 \nRoom number 2 \n"
    end
  end
  describe "Manifest#list_reservations_by_date" do
    it "returns a string" do
      expect(manifest.list_reservations_by_date).must_be_instance_of String
    end
  end
end
