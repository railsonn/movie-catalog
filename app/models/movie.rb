class Movie < ApplicationRecord
  has_many :movies_genres
  has_many :genres, through: :movies_genres
  validates :imdbID, presence: true, uniqueness: true

  def self.save_from_api(api_movies)
    api_movies.each do |api_movie|
      movie = find_or_initialize_by(imdbID: api_movie["imdbID"])

      movie.save(
        title:  api_movie["Title"],
        year:   api_movie["Year"],
        poster: api_movie["Poster"],
        movie_type: api_movie["Type"]
      )
    end
  end
end
