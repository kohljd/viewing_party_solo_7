class MovieReview
  attr_reader :review_id,
              :author,
              :content

  def initialize(attributes)
    @review_id = attributes[:id]
    @author = attributes[:author]
    @content = attributes[:content]
  end
end