class GlobalSummary
  # include HTTParty
  # base_uri "https://www.omdbapi.com"

  # def self.search(title)
  #   get("/", query: {
  #     s: title,
  #     apikey: api_key
  #   })
  # end

  # def self.find_by_title(title)
  #   get("/", query: {
  #     t: title,
  #     apikey: api_key
  #   })
  # end

  # def self.find_by_imdb_id(imdb_id)
  #   get("/", query: {
  #     i: imdb_id,
  #     apikey: api_key
  #   })
  # end

  # def self.api_key
  #   ENV["APIKEY"]
  # end


  CURRENT_TITLES = ["movie", "the", "man"]

  def general(title, page)
    results = []

    if title.blank?
      CURRENT_TITLES.each do |search_term|
        response = OmdbService.search_recent(search_term, page)
        results += response["Search"] if valid_response?(response)
      end
    else
      response = OmdbService.search(title, page)
      results += response["Search"] if valid_response?(response)
    end

    unique_results = results.uniq { |movie| movie["imdbID"]}

 
    unique_results
  end


  def save_movies(results)
    results.each do |api_movie|
      Movie.find_or_create_by(imdb_id: api_movie["imdbID"]) do |movie|
        movie.title  = api_movie["Title"]
        movie.year   = api_movie["Year"]
        movie.poster = api_movie["Poster"]
      end
    end
  end



  KEYWORDS = [
    "batman",
    "harry potter",
    "star wars",
    "avengers",
    "lord of the rings",
    "lego"
  ]

  def movies(page)
    movies = []

    KEYWORDS.each do |keyword|
      response = OmdbService.search(keyword, page)
      next unless valid_response?(response)

      movies += response["Search"]
    end


    movies.uniq { |m| m["imdbID"] }   
  end

  private

  def valid_response?(response)
    response.success? && response["Response"] == "True"
  end
end