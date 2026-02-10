class GlobalSummary
  include HTTParty
  base_uri "https://www.omdbapi.com"

  def self.search(title)
    get("/", query: {
      s: title,
      apikey: api_key
    })
  end

  def self.find_by_title(title)
    get("/", query: {
      t: title,
      apikey: api_key
    })
  end

  def self.find_by_imdb_id(imdb_id)
    get("/", query: {
      i: imdb_id,
      apikey: api_key
    })
  end

  def self.api_key
    ENV["APIKEY"]
  end
end