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


  def general
    # Exemplo: filmes em destaque
    response = OmdbService.search("batman")

    return [] unless valid_response?(response)

    response["Search"]
  end

  LETTERS = ("a".."z").to_a

  def movies
    movies = []

    LETTERS.each do |letter|
      response = OmdbService.search(letter)

      next unless valid_response?(response)

      movies += response["Search"]
    end

    movies.uniq { |movie| movie["imdbID"] }
  end

  private

  def valid_response?(response)
    response.success? && response["Response"] == "True"
  end
end