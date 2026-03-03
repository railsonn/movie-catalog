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

  CATEGORIES_GENRES = [
    "Ação",
    "Aventura",
    "Comédia",
    "Crime",
    "Drama",
    "Fantasia",
    "Terror",
    "Mistério",
    "Romance",
    "Ficção científica",
    "Guerra",
    "Faroeste"
  ]

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

  def format_genre_to_id(genre)
    genres_invert = TMDB_MOVIE_GENRES.invert
    genres_invert[genre]
  end
end