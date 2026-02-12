class HomeController < ApplicationController
  require "ostruct"
  before_action :set_global_summary_service

  def index
    page = params[:page] || 1
    title = params[:q]
  
    # se tiver titulo 
    if title.present?
      # 1️⃣ Busca no banco primeiro
      @movies = Movie.where("title LIKE?", "%#{title}%").limit(12)

      # 2️⃣ Se não encontrar nada, busca na API
      if @movies.empty?
        @movies = @summary_service.general(title, page)

        Movie.save_from_api(@movies)
        transform_requests_result(@movies)
      end
    else 

      @movies = Movie.all.limit(10)
    end

    @movies = @summary_service.general(title, page)
    transform_requests_result(@movies)

    # @count_movies = Movie.count / 10
    # @next_movies = Movie.all.limit(10).offset(10)
  end

  def transform_requests_result(movies)
    @movies = movies.map do |api_movie|
      OpenStruct.new(
        title: api_movie["Title"],
        year: api_movie["Year"],
        poster: api_movie["Poster"],
        movie_type: api_movie["Type"],
        imdb_id: api_movie["imdbID"]
      )
    end
  end

  private

  def set_global_summary_service
    @summary_service = GlobalSummary.new
  end
end
