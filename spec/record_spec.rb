require_relative "spec_helper"
describe "Record class" do
  describe "initialize" do
    it "can be instantiated" do
      expect(Hotel::Record.new(1)).must_be_instance_of Hotel::Record
    end

    it "validates id" do
      expect { Hotel::Record.new(0) }.must_raise ArgumentError
      expect { Hotel::Record.new(-1) }.must_raise ArgumentError
      expect { Hotel::Record.new(21) }.must_raise ArgumentError
    end
  end
end
