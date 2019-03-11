require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'date'
require_relative 'spec_helper'
require_relative '../lib/booking_manager.rb'
require_relative '../lib/reservations.rb'

describe "initialize" do
  before do
    @dates = Hotel::DateSpan.new("2019-07-19", "2018-07-21")
  end

  it "is an instance of Reservation" do
    expect(@dates).must_be_kind_of Hotel::DateSpan
  end

  it "Takes check_in, check_out" do
    expect(@dates).must_respond_to :check_in
    expect(@dates).must_respond_to :check_out
  end
end