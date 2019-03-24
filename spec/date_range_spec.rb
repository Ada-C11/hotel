require_relative 'spec_helper.rb'
require 'date'


describe "DateRange class" do
  before do
    @test_daterange = Hotel::DateRange.new(Date.new(2019,3,11), Date.new(2019,3,15))
  end 
  
  describe "instantiates the dates class" do
    it "creates an instantiation of the date class" do
      expect(@test_daterange).must_be_kind_of(Hotel::DateRange)
    end

    it "raises an ArgumentError if check out date is before check in date" do
      check_in = Date.new(2019,2,10)
      check_out = Date.new(2018,2,10)
      expect{Hotel::DateRange.new(check_in, check_out)}.must_raise ArgumentError
    end

    it "raises an Argument Error for invalid date ranges." do
      expect{Hotel::DateRange.new(0, 0)}.must_raise ArgumentError
    end

    it "raises an Argument Error if the check in date is the same as the check out date" do
      expect{Hotel::DateRange.new(Date.new(2019,3,11), Date.new(2019,3,11))}.must_raise ArgumentError
    end
  end

  describe 'total stay method' do
    it 'calculates the total stay' do
      expect(@test_daterange.total_stay).must_equal(4)
    end
  end

  describe 'date check method' do
    it 'returns true if valid date is within daterange' do
        expect( @test_daterange.date_check(Date.new(2019,3,12)) ).must_equal(true)
        expect( @test_daterange.date_check(Date.new(2019,3,13)) ).must_equal(true)
        expect( @test_daterange.date_check(Date.new(2019,3,14)) ).must_equal(true)
    end

  end

end