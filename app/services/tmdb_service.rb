# class TmdbService
#   include HTTParty
#   base_uri "https://www.omdbapi.com/"
#   format :json
#   default_params apikey: ENV["apikey"]

#   def self.search(title, page)
#     response = HTTParty.get(
#       "https://api.themoviedb.org/3/search/movie",
#       query: {
#         api_key: ENV['Apikey'],
#         language: 'pt-BR',
#         query: title,
#         page: page
#       }
#     )

#     # Retorna apenas os resultados
#     response["results"]
#   end

class TmdbService
  include HTTParty
  base_uri "https://api.themoviedb.org/3"
  format :json
  default_params apikey: ENV["apikey"]

  def self.search(title, page)
    get("/search/movie", query: {
      api_key: ENV['apikey'],
      language: 'pt-BR',
      query: title,
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