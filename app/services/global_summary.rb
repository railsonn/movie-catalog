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


  def general(title, page)
    # Exemplo: filmes em destaque
    response = OmdbService.search(title, page)

    return [] unless valid_response?(response)

    response["Search"]
  end


  KEYWORDS = [
    "batman",
    "harry potter",
    "star wars",
    "avengers",
    "lord of the rings"
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