class Movie < ApplicationRecord
  has_many :movies_genres
  has_many :genres, through: :movies_genres
end
