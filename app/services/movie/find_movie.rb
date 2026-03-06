module Movie
  class FindMovieService
    def find(movie_id)
      response = TmdbService.find(movie_id)
      results = response if valid_response_search_id?(response)
    end


    private 

    def valid_response_search_id?(response)
      response.code == 200 && response["id"].present?
    end
  end
end