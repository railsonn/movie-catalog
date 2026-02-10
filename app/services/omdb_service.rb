class OmdbService
  include HTTParty
  base_uri "https://www.omdbapi.com"
  format :json
  default_params apikey: ENV["apikey"]

  def self.search(title, page)
    get("/", query: {
      s: title,
      page: page,
      apikey: ENV["apikey"]
    })
  end

  def self.find(imdb_id)
    get("/", query: { i: imdb_id })
  end
end