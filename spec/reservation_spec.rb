require_relative "spec_helper"

describe "Reservation class" do
  before do
    def make_reservation(start_date: start_date, end_date: end_date, room: room, id: id)
      HotelSystem::Reservation.new(start_date: start_date, end_date: end_date, room: room, id: id)
    end
  end
  describe "initialize method" do
    before do
      @new_res = make_reservation(start_date: "01 Feb 2020", end_date: "08 Feb 2020", room: "I'm a room!", id: 1)
    end
    it "creates an instance of Reservation" do
      expect(@new_res).must_be_instance_of HotelSystem::Reservation
    end
  end
end
