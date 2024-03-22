class ViewingParty < ApplicationRecord
  validates_presence_of :date, :start_time, :movie_id, :duration

  validate :duration_more_than_run_time
  validate :check_date_and_start_time

  has_many :user_parties
  has_many :users, through: :user_parties

  def duration_more_than_run_time
    return unless duration.present? && movie_id.present?
    if duration < MovieFacade.movie(movie_id).runtime.to_i
      errors.add(:duration, "shorter than movie's runtime")
    end
  end

  def check_date_and_start_time
    return unless date.present? && start_time.present?
    parsed_date = Date.parse(date)
    parsed_time = Time.parse(start_time)

    date_time_combo = DateTime.new(parsed_date.year, parsed_date.month, parsed_date.day, parsed_time.hour, parsed_time.min)
    unless date_time_combo >= DateTime.now
      errors.add(:date, :start_time, message: "can't be in the past")
    end
  end

  def find_host
    users.where("user_parties.host = true").first
  end
end
