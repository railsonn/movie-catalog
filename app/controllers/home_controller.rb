class HomeController < ApplicationController
  before_action :set_global_summary_service

  def index
    page = params[:page] || 1
    title = params[:q]
  
    if title.present?
      # 1️⃣ Busca no banco primeiro
      @movies = Movie.where("title LIKE?", "%#{title}%").limit(12)

      # 2️⃣ Se não encontrar nada, busca na API
      if @movies.empty?
        @movies = @summary_service.general(title, page)
        Movie.save_from_api(@movies)
      end
    else 
      puts "#{Movie.count } =================="
      @movies = @summary_service.general(title, page)
      # else
      #   puts "#{Movie.count} ==============================================="
      #   @movies = Movie.all.limit(20)
      # end
    end
    
    @next_movies = @summary_service.general(title, page.to_i + 1)
  end

  private

  def set_global_summary_service
    @summary_service = GlobalSummary.new
  end
end
