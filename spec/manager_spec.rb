require_relative "spec_helper.rb"

describe "Hotel Manager Setup" do
  let (:this_manager) { this_manager = Hotel::Manager.new }
  it "Make 20 rooms" do
    expect(this_manager.rooms_reservations_hash.length).must_equal 20
  end

  it "List all rooms" do
    skip
    expect(this_manager.list_rooms).must_include 13
    expect(this_manager.list_rooms).wont_include 21
    expect(this_manager.list_rooms).wont_include 0
  end
end
