class TmdbService
  include HTTParty
  base_uri "https://api.themoviedb.org/3"
  format :json
  default_params apikey: ENV["apikey"]

  def self.search(title, page)
    get("/movie/popular", query: {
      api_key: ENV['apikey'],
      language: 'pt-BR',
      query: title,
      page: page
    })
  end

  def self.search_recent(title, page)
    year = Time.current.year
    get("/movie/popular", query: {
      api_key: ENV['apikey'],
      language: 'pt-BR',
      query: title,
      y: year,
      page: page
    })
  end

  def self.find(imdb_id)
    get("/", query: { i: imdb_id })
  end
end