require "rails_helper"

RSpec.describe ViewingParty, type: :model do
  describe "validations" do
    it { should validate_presence_of :date }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :duration }
    it { should validate_presence_of :movie_id }
  end

  describe "relationships" do
    it { should have_many :user_parties }
    it { should have_many(:users).through(:user_parties) }
  end

  describe "instance methods" do
    it "returns user that is hosting the party" do
      user_1 = User.create!(name: "Sam", email: "same@mail.com")
      user_2 = User.create!(name: "Tommy", email: "tommy@email.com")
      party = ViewingParty.create!(date: "2023-12-01", start_time: "07:25", duration: 175, movie_id: 546554)

      UserParty.create!(user_id: user_1.id, viewing_party_id: party.id, host: true)
      UserParty.create!(user_id: user_2.id, viewing_party_id: party.id, host: false)

       expect(party.find_host).to eq (user_1)
    end
  end
end