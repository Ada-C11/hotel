require_relative 'spec_helper'
require 'date'

describe 'Reservation class' do
  describe 'initialize' do
    before do
      @reservation = HotelSystem::Reservation.new(room_number: 1,
      start_date: 03/11/2019, 
      end_date: 03/14/2019,
      guest: "Sam")
    end

    it "is an instance of a reservation" do
      expect(@reservation).must_be_kind_of HotelSystem::Reservation
    end
  end
end