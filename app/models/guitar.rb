class Guitar < ActiveRecord::Base
  attr_accessible :model, :year
  
  # creates a new guitar record and
  # searches additional info from external sources
  def register
    self.save && search_guitar_reviews
  end

  def to_s
    self.model + self.year.to_s
  end

  private

    def search_guitar_reviews
      reviews_search = GuitarReviewsSearch.new(self.to_s)
      Rails.queue.push(reviews_search)
    end

end
