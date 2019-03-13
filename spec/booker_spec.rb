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
    it "adds check_in and check_out dates to unavailable array to manifest by room id" do
      room_id = 1
      day1 = "march 20, 2020"
      day2 = "march 28, 2020"
      reservation1 = Hotel::Reservation.new(check_in: day1, check_out: day2)
      room = manifest.find_room(room_id)
      booker.book_room(reservation1, room)
      expect(room.unavailable_list).must_be_instance_of Array
      expect(room.unavailable_list.last.check_in).must_be_instance_of Date
      expect(room.unavailable_list.last.check_in).must_equal Date.new(2020, 03, 20)
    end
  end
end
