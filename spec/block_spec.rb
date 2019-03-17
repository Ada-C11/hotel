require_relative "spec_helper"

describe "Block" do
  let(:valid_block) {
    Hotel::Block.new(check_in: Date.parse("March 20, 2020"), check_out: Date.parse("March 27, 2020"), percent_discount: 15)
  }
  describe "Block#initialize" do
    it "is an instance of Block" do
      expect(valid_block).must_be_instance_of Hotel::Block
    end

    it "instance variable check_in is correct" do
      expect(valid_block).must_respond_to :check_in
      expect(valid_block.check_in).must_be_instance_of Date
      expect(valid_block.check_in).must_equal Date.new(2020, 03, 20)
    end

    it "instance variable check_out is correct" do
      expect(valid_block).must_respond_to :check_out
      expect(valid_block.check_out).must_be_instance_of Date
      expect(valid_block.check_out).must_equal Date.new(2020, 03, 27)
    end

    it "will raise exception if invalid date range used" do
      date1 = (Time.new + 172800).to_date
      date2 = (Time.new + 172800 * 4).to_date
      past = Date.parse("march 2, 2019")
      expect { Hotel::Block.new(check_in: date2, check_out: date1, percent_discount: 15) }.must_raise InvalidDateRangeError
      expect { Hotel::Block.new(check_in: past, check_out: date1, percent_discount: 15) }.must_raise InvalidDateRangeError
    end
  end

  let(:date1) { (Time.new + 172800).to_date }
  let(:date2) { (Time.new + 172800 * 4).to_date }
  let(:past) { Date.new(2019, 02, 13) }
  describe "Block#valid_date_range?" do
    it "check_in is before check_out" do
      expect(valid_block.valid_date_range?(date1, date2)).must_equal true
    end

    it "check_in is same as end" do
      expect(valid_block.valid_date_range?(date2, date2)).must_equal false
    end

    it "check_in is before today" do
      expect(valid_block.valid_date_range?(past, date1)).must_equal false
    end
  end
  describe "Block#generate_confirmation_id" do
    before do
      @blocks = []
      3.times do
        @blocks << Hotel::Block.new(check_in: Date.parse("March 20, 2020"), check_out: Date.parse("March 27, 2020"), percent_discount: 15)
      end
    end
    it "will generate different id for each block and save it to the new instance" do
      expect(@blocks[0].id != @blocks[1].id).must_equal true
      expect(@blocks[1].id != @blocks[2].id).must_equal true
      expect(@blocks[2].id != @blocks[0].id).must_equal true
    end
    it "each id will start with 'B'" do
      3.times do |i|
        expect(@blocks[i].id[0] == "B").must_equal true
      end
    end
  end
end
