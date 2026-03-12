module Request
  class CategoryFilm
    def categories_genres
      @movie_genres = CATEGORIES_GENRES
    end


    def categories_list_movies(genre, page)
      genre_id = format_genre_to_id(genre)
      response = TmdbService.search_categories(genre_id, page)
      
      if valid_response?(response)
        unique_results = response["results"].uniq { |movie| movie["id"]}
        unique_results.each { |result| format_genres(result)}
      end
    end
  end
end