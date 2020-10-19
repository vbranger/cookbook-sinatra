class Recipe
  attr_reader :description, :rating, :prep_time
  attr_accessor :mark, :name

  def initialize(name, description, rating, mark = false, prep_time)
    @name = name
    @description = description
    @rating = rating
    @mark = mark
    @prep_time = prep_time
  end
end
