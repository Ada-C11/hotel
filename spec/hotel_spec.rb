require_relative 'spec_helper'

describe "hotel" do
  let(:hotel) do
    hotel = Hotel.new
  end

  it "get reservations inclusive" do

  end 
  it 'validate date range' do
    seventh = Time.parse("2018-07-07")
    eleventh = Time.parse("2018-07-11")
    expect{hotel.validate_date_range(eleventh, seventh)}.must_raise ArgumentError
  end
end
