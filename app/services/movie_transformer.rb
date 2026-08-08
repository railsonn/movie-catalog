class MovieTransformer
  # Transforma os resultados da API em objetos
  def self.transform_requests_result(movies)
    movies.map do |api_movie|
      base_url = "https://image.tmdb.org/t/p/w500"
      poster_path = api_movie["poster_path"]
      poster_url = "#{base_url}#{poster_path}"

      OpenStruct.new(
        title: api_movie["original_title"],
        year: api_movie["release_date"],
        poster: poster_url,
        genre: api_movie["genre_ids"],
        vote_average: api_movie["vote_average"],
        adult: api_movie["adult"],
        overview: api_movie["overview"],
        id_movie: api_movie["id"]
      )
    end
  end
end
