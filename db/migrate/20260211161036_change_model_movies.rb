class ChangeModelMovies < ActiveRecord::Migration[8.0]
  def change
    # Remove colunas que não serão mais usadas
    remove_column :movies, :original_title, :string
    remove_column :movies, :overview, :text
    remove_column :movies, :release_date, :date
    remove_column :movies, :poster_path, :string
    remove_column :movies, :backdrop_path, :string
    remove_column :movies, :vote_average, :float
    remove_column :movies, :vote_count, :integer
    remove_column :movies, :popularity, :float

    # Adiciona colunas novas (se não existirem)
    add_column :movies, :type, :string unless column_exists?(:movies, :type)
    add_column :movies, :year, :integer unless column_exists?(:movies, :year)
    add_column :movies, :poster, :string unless column_exists?(:movies, :poster)

    # Garante índice único no imdbID
    add_index :movies, :imdbID, unique: true
  end

end
