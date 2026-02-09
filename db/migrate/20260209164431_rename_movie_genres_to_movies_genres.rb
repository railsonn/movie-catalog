class RenameMovieGenresToMoviesGenres < ActiveRecord::Migration[8.0]
  def change
    rename_table :movie_genres, :movies_genres
  end
end
