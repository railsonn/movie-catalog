class GlobalSummary

  CURRENT_TITLES = ["movie", "man", "the"]

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

  def general(title, page, movie_id)
    results = []

    # if title.blank?
    #   CURRENT_TITLES.each do |search_term|
    #     response = TmdbService.search_recent(search_term, page)
    #     results += response["results"] if valid_response?(response)
    #   end
    # else
    #   response = TmdbService.search(title, page)
    #   results += response["results"] if valid_response?(response)
    # end

    if movie_id.present?
      response = TmdbService.find(movie_id)
      binding.irb
      results += response["results"]
    end


    
    unique_results = results.uniq { |movie| movie["id"]}

    # funcao para atribuir os generos em string para cada id do genre_ids
    unique_results.each{ |result| format_genres(result) }
    unique_results
  end
  
  def format_genres(result)
    result["genre_ids"].each_with_index do |genre_id, i| 
      result["genre_ids"][i] = TMDB_MOVIE_GENRES[genre_id]
    end
    .compact
    .join(", ")
  end



  KEYWORDS = [
    "harry potter",
    "star wars",
    "avengers",
    "lord of the rings",
    "lego"
  ]

  def movies(page)
    results = []

    KEYWORDS.each do |keyword|
      response = TmdbService.search(keyword, page)
      next unless valid_response?(response)

      results += response["results"]
    end


    unique_results = results.uniq { |m| m["id"] }  
    unique_results.each { |result| format_genres(result) }
  end

  private

  def valid_response?(response)
    response && response["results"] && !response["results"].empty?
  end
end