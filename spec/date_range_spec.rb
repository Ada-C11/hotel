require_relative "spec_helper"

describe "Date Range" do
    before do
        @start_date = Date.parse('11th Mar 2019')
        @end_date = Date.parse('15th Mar 2019')
        @requested_date = Date.parse('13 Mar 2019')
    end

    it "determines if given dates are valid" do
        expect(HotelManagementSystem::DateRange.is_valid?(@start_date, @end_date)).must_equal true
    end

    it "determines if requested date is within range" do
        expect(HotelManagementSystem::DateRange.within_range?(@start_date, @end_date, @requested_date)).must_equal true
    end

    it "determines if given dates are invalid" do
        expect(HotelManagementSystem::DateRange.is_valid?(Date.parse('15th Mar 2019'), Date.parse('11th Mar 2019'))).must_equal false
    end

    it "determines if requested date is not within range" do
        expect(HotelManagementSystem::DateRange.within_range?(Date.parse('15th Mar 2019'), Date.parse('11th Mar 2019'), Date.parse('18 Mar 2019'))).must_equal false
    end


end
