class HomeController < ApplicationController
  before_action :set_global_summary_service  
  before_action :set_all_movies_service
  require "ostruct"


  def index
    page = params[:page] || 1
    title = params[:q]

    # se tiver titulo 
    if title.present?
      # 1️⃣ Busca no banco primeiro
      @movies = @all_movie_service.general(title, page)
      binding.irb
      # pega os filmes na requisicao da api e salva no banco trocando movie["Title"] por movie.title
      transform_requests_result(@movies)

      # 2️⃣ Se não encontrar nada, busca na API
      if @movies.empty?

        @movies = @all_movie_service.general(title, page)
        transform_requests_result(@movies)
      end
    else 

      @movies = @all_movie_service.general(title, page) 
      transform_requests_result(@movies)

    end

    @next_movies = @all_movie_service.general(title, page.to_i + 1)
    transform_requests_result(@next_movies)
  end


  def transform_requests_result(movies)
    @movies = movies.map do |api_movie|
      base_url = "https://image.tmdb.org/t/p/w500"  
      poster_path = api_movie["poster_path"]
      poster_url = "#{base_url}#{poster_path}"

      OpenStruct.new(
        title: api_movie["original_title"],
        year: api_movie["release_date"],
        poster: poster_url,
        genre: api_movie["genre_ids"],
        vote_average: api_movie["vote_average"],
        adult: api_movie["adult"],
        overview: api_movie["overview"],
        id_movie: api_movie["id"]
      )
    end
  end

  

  private

  def set_all_movies_service
    @all_movie_service = AllMovieService.new
  end

  def set_global_summary_service
    @summary_service = GlobalSummary.new
  end

end
