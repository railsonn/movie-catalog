class OmdbService
  include HTTParty
  base_uri "https://api.themoviedb.org/3/discover/movie"
  format :json
  default_params apikey: ENV["apikey"]

  def self.search(title, page)
    get("/", query: {
      s: title,
      page: page
    })
  end

  def self.search_recent(title, page)
    year = Time.current.year
    get("/", query: {
      s: title,
      y: year,
      page: page
    })
  end

  def self.find(imdb_id)
    get("/", query: { i: imdb_id })
  end
end