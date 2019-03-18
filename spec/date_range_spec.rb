require_relative "spec_helper"

describe "DateRange" do
    before do
        @check_in_date = Hotel::DateRange.check_in_date(2019, 02, 10)
        @check_out_date = Hotel::DateRange.check_out_date(2019, 02, 02)
    end
    
    it "Returns false if given invalid dates" do
       expect(Hotel::DateRange.valid_dates?(@check_in_date, @check_out_date)).must_equal false
    end

    describe "Date Range" do

        before do
            @check_in_date = Hotel::DateRange.check_in_date(2019, 02, 02)
            @check_out_date = Hotel::DateRange.check_out_date(2019, 02, 10)
        end

        it "creates an array of dates" do
            expect(Hotel::DateRange.date_range(@check_in_date, @check_out_date)).must_be_instance_of Array
        end

    end

    describe "Within_Range" do

        before do
            @check_in_date = Hotel::DateRange.check_in_date(2019, 02, 02)
            @check_out_date = Hotel::DateRange.check_out_date(2019, 02, 10)
        end


        it "returns true if within range" do
            # check date is between start and end
            expect(Hotel::DateRange.within_range(@check_in_date, @check_out_date, Date.parse("20190205"))).must_equal true
            # check date is start date
            expect(Hotel::DateRange.within_range(@check_in_date, @check_out_date, Date.parse("20190202"))).must_equal true
        end

        it "returns false if check date is end date" do
            expect(Hotel::DateRange.within_range(@check_in_date, @check_out_date, Date.parse("20190210"))).must_equal false
        end

        it "returns false if check date is not within dates" do
            # check date is before start date
            expect(Hotel::DateRange.within_range(@check_in_date, @check_out_date, Date.parse("20190201"))).must_equal false
            # check date is after end date
            expect(Hotel::DateRange.within_range(@check_in_date, @check_out_date, Date.parse("20190211"))).must_equal false
        end
    end
end
      