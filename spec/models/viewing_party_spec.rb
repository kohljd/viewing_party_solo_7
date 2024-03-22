require "rails_helper"

RSpec.describe ViewingParty, type: :model do
  before do
    @movie = double(Movie, runtime: 60, movie_id: 546554)
    @movie_id = 546554
    allow(MovieFacade).to receive(:movie).with(@movie_id).and_return(@movie)
  end

  describe "validations" do
    it { should validate_presence_of :date }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :duration }
    it { should validate_presence_of :movie_id }
  end


  it "date/start_time must be in the future" do
    past_date = (DateTime.now - 1.day).to_fs(:db)
    past_start = (DateTime.now - 2.hours).to_fs(:db)
    past_party = ViewingParty.new(date: past_date, start_time: past_start, movie_id: @movie_id, duration: 100)
    expect(past_party).to_not be_valid

    future_date = (DateTime.now + 1.day).to_fs(:db)
    future_start = (DateTime.now + 2.hours).to_fs(:db)
    future_party = ViewingParty.new(date: future_date, start_time: future_start, movie_id: @movie_id, duration: 100)

    expect(future_party).to be_valid
  end

  describe "relationships" do
    it { should have_many :user_parties }
    it { should have_many(:users).through(:user_parties) }
  end

  describe "instance methods" do
    it "returns user that is hosting the party" do
      user_1 = User.create!(name: "Sam", email: "same@mail.com")
      user_2 = User.create!(name: "Tommy", email: "tommy@email.com")
      day = (DateTime.now + 1.day).to_fs(:db)

      party = ViewingParty.create!(date: day, start_time: "07:25", duration: 175, movie_id: 546554)

      UserParty.create!(user_id: user_1.id, viewing_party_id: party.id, host: true)
      UserParty.create!(user_id: user_2.id, viewing_party_id: party.id, host: false)

      expect(party.find_host).to eq(user_1)
    end
  end
end