module Request
  class FindFilm
    def find(movie_id)
      response = TmdbService.find(movie_id)
      results = response if valid_response_search_id?(response)


      format_genres(results) if results.present?
    end


    private 

    def valid_response_search_id?(response)
      response.code == 200 && response["id"].present?
    end

    def format_genres(result)
      result["genre_ids"].each_with_index do |genre_id, i| 
        result["genre_ids"][i] = TMDB_MOVIE_GENRES[genre_id]
      end
      .compact
      .join(", ")
    end
  end
end