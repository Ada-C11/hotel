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
    it "adds range of dates to unavailable array to manifest by room id" do
      room_id = manifest.find_room(11)
      room_11 = booker.book_room((Date.new(2020, 11, 11)...Date.new(2020, 11, 14)), room_id)
      expect(room_11.unavailable).must_be_instance_of Array
      expect(room_11.unavailable[0]).must_be_instance_of Date
      expect(room_11.unavailable.include?(Date.new(2020, 11, 12))).must_equal true
    end
  end
end
