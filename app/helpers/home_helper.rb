module HomeHelper
  def format_text(movie)
    movie.genre.split('"').join(', ')
  end
end