class HomeController < ApplicationController
  before_action :set_global_summary_service

  def index
    page = params[:page] || 1
    title = params[:q]
  
    if params[:title].present?
      # 1️⃣ Busca no banco primeiro
      @movies = Movie.where(" title ILIKE?", "%#{params[:title]}%")

      # 2️⃣ Se não encontrar nada, busca na API
      if @movies.empty?
        @movies = @summary_service.general(title, page)
        Movie.save_from_api(api_movies)

        @movies = Movie.where("title ILIKE ?", "%#{params[:title]}%")
      end
    else 
      @movies = Movie.all.limit(20)
    end
    
    @next_movies = @summary_service.general(title, page.to_i + 1)

    # Movie.save_from_api(@movies)
  end

  private

  def set_global_summary_service
    @summary_service = GlobalSummary.new
  end
end
