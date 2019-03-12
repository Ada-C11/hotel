require_relative "spec_helper"

describe "DateRange" do
    
    it "Raises ArgumentError if given invalid dates" do
       expect {Hotel::DateRange.valid_dates?("20190210", "20190202")}.must_raise ArgumentError
    end

    describe "Within_Range" do
        it "returns true if within range" do
            # check date is between start and end
            expect(Hotel::DateRange.within_range("20190202", "20190210", "20190205")).must_equal true
            # check date is start date
            expect(Hotel::DateRange.within_range("20190202", "20190210", "20190202")).must_equal true
        end

        it "returns false if check date is end date" do
            expect(Hotel::DateRange.within_range("20190202", "20190210", "20190210")).must_equal false
        end

        it "returns false if check date is not within dates" do
            # check date is before start date
            expect(Hotel::DateRange.within_range("20190202", "20190210", "20190201")).must_equal false
            # check date is after end date
            expect(Hotel::DateRange.within_range("20190202", "20190210", "20190211")).must_equal false
        end
    end
end
      