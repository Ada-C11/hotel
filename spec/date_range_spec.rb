require_relative "spec_helper"

describe "DateRange class" do
  describe "initialize method" do
    before do
      start_date = "02-01-2020"
      end_date = "02-08-2020"
      @new_range = HotelSystem::DateRange.new(start_date, end_date)
    end
    it "creates an object of type DateRange" do
      expect(@new_range).must_be_instance_of HotelSystem::DateRange
    end
  end
end
