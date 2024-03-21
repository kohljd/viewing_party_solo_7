class MovieReview
  attr_reader :review_id,
              :author,
              :content,
              :movie_rating,
              :created_at

  def initialize(attributes)
    @review_id = attributes[:id]
    @author = attributes[:author]
    @content = attributes[:content]
    @movie_rating = attributes[:author_details][:rating]
    @created_at = attributes[:created_at]
  end

  def date_written
    Date.parse(@created_at).to_fs(:long_ordinal)
  end
end