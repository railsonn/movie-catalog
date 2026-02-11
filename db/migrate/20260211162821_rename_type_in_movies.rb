class RenameTypeInMovies < ActiveRecord::Migration[8.0]
  def change
    rename_column :movies, :type, :movie_type
  end
end
