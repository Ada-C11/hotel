require_relative "spec_helper.rb"

describe "Booker" do
  let(:booker) { Hotel::Booker.new }
  let(:manifest) { booker.manifest }
  describe "Booker#initialize" do
    it "is a type of Booker" do
      expect(booker).must_be_instance_of Hotel::Booker
    end

    it "has instance variable of type Manifest" do
      expect(manifest).must_be_instance_of Hotel::Manifest
    end
  end

  describe "Booker#book_room" do
    it "adds reservation to unavailable array to manifest for a given room" do
      room_id = 1
      day1 = Date.parse("march 20, 2020")
      day2 = Date.parse("march 28, 2020")
      reservation1 = Hotel::Reservation.new(check_in: day1, check_out: day2)
      room = manifest.find_room(room_id)
      booker.book_room(reservation1, room)
      expect(room.unavailable_list[-1]).must_be_instance_of Hotel::Reservation
    end

    it "adds reservation correctly" do
    end
  end

  describe "Booker#cost_of_booking" do
  end
end
