require_relative "spec_helper"

describe "Manifest" do
  let(:manifest) { Hotel::Manifest.new }
  it "is an instance of RoomManifest" do
    expect(manifest).must_be_instance_of Hotel::Manifest
  end
end
