class CreateMovies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies do |t|
      t.integer :tmdb_id
      t.string :title
      t.string :original_title
      t.text :overview
      t.date :release_date
      t.string :poster_path
      t.string :backdrop_path
      t.float :vote_average
      t.integer :vote_count
      t.float :popularity

      t.timestamps
    end
  end
end
