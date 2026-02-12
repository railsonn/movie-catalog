class Movie < ApplicationRecord
  has_many :movies_genres
  has_many :genres, through: :movies_genres
  validates :imdbID, presence: true, uniqueness: true

  def self.save_from_api(api_movies)
    api_movies.each do |api_movie|
      movie = find_or_initialize_by(imdbID: api_movie.imdbID)

      movie.update(
        title:  api_movie.title,
        year:   api_movie.year,
        poster: api_movie.poster,
        movie_type: api_movie.movie_type
      )
    end
  end
end
