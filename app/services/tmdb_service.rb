class TmdbService
  include HTTParty
  base_uri "https://api.themoviedb.org/3"
  format :json

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
    get("/search/movie", query: {
      api_key: ENV['apikey'],
      language: 'pt-BR',
      query: title,
      primary_release_year: year,
      page: page
    })
  end

  def self.search_categories(genre_ids)
    get("/discover/movie", query: {
      api_key: ENV['apikey'],
      language: 'pt-BR',
      with_genres: genre_ids,
      page: 1
    })
  end

  def self.find(movie_id)
    get("/movie/#{movie_id}?append_to_response=credits", query: {
      api_key: ENV['apikey'],
      language: 'pt-BR',
      i: movie_id 
      })
  end
end