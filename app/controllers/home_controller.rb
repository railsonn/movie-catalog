class HomeController < ApplicationController
  before_action :set_global_summary_service
  require "ostruct"

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

        @movies = @movies.map do |api_movie|
          OpenStruct.new(
            title: api_movie["Title"],
            year: api_movie["Year"],
            poster: api_movie["Poster"],
            movie_type: api_movie["Type"],
            imdb_id: api_movie["imdbID"]
          )
        end
        Movie.save_from_api(@movies)
      end
    else 
      @movies = @summary_service.general(title, page)

      @movies = @movies.map do |api_movie|
        OpenStruct.new(
          title: api_movie["Title"],
          year: api_movie["Year"],
          poster: api_movie["Poster"],
          imdb_id: api_movie["imdbID"]
        )
      end
    end

    @next_movies = @summary_service.general(title, page.to_i + 1)
  end

  private

  def set_global_summary_service
    @summary_service = GlobalSummary.new
  end
end
