module Request
  class FindFilm

  TMDB_MOVIE_GENRES = {
    28 => "Ação",
    12 => "Aventura",
    16 => "Animação",
    35 => "Comédia",
    80 => "Crime",
    99 => "Documentário",
    18 => "Drama",
    10751 => "Família",
    14 => "Fantasia",
    36 => "História",
    27 => "Terror",
    10402 => "Música",
    9648 => "Mistério",
    10749 => "Romance",
    878 => "Ficção científica",
    10770 => "Cinema TV",
    53 => "Thriller",
    10752 => "Guerra",
    37 => "Faroeste"
  }

    def find(movie_id)
      binding.irb
      response = TmdbService.find(movie_id)
      results = response if valid_response_search_id?(response)

      format_genres(results) if results.present?
    end

    private 

    def valid_response_search_id?(response)
      response.code == 200 && response["id"].present?
    end

    def format_genres(result)
      result["genre"]["id"].each_with_index do |genre_id, i| 
        result["genre_ids"][i] = TMDB_MOVIE_GENRES[genre_id]
      end
      .compact
      .join(", ")
    end
  end
end