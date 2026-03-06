 module Movie
  class AllMoviesService
    def general(title, page)
      results = []

      if title.blank?
        CURRENT_TITLES.each do |search_term|
          response = TmdbService.search_recent(search_term, page)
          results += response["results"] if valid_response?(response)
        end
      else
        response = TmdbService.search(title, page)
        results += response["results"] if valid_response?(response)
      end

      unique_results = results.uniq { |movie| movie["id"]}

      # funcao para atribuir os generos em string para cada id do genre_ids
      unique_results.each{ |result| format_genres(result) }
    end

    private 

    def valid_response?(response)
      response && response["results"] && !response["results"].empty?
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