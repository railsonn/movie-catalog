module HomeHelper
  # metodo para formatar o genero do filme, pegando apenas a parte antes do " e substituindo por ,
  def format_text(movie)
    movie.genre.split('"').join(', ')
  end
end