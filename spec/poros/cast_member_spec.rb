require "rails_helper"

RSpec.describe CastMember do
  it "is a movie with attributes" do
    attributes = {
      id: 8784,
      name: "Daniel Craig",
      character: "Benoit Blanc"
    }

    cast_member = CastMember.new(attributes)
    
    expect(cast_member).to be_a CastMember
    expect(cast_member.cast_member_id).to eq(8784)
    expect(cast_member.name).to eq("Daniel Craig")
    expect(cast_member.character).to eq("Benoit Blanc")
  end
end