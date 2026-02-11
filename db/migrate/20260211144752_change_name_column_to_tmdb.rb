class ChangeNameColumnToTmdb < ActiveRecord::Migration[8.0]
  def change
    rename_column :movies, :tmdb_id, :imdbID
    change_column :movies, :imdbID, :string
  end
end
