class GuitarReviewsSearch

  def initialize(name)
    @name = name
  end

  def run
    p "searching reviews for #{@name}"
    sleep 10
    p "done!"
  end
end
