class HomeController < ApplicationController
  require "ostruct"

  # Carrega o serviço de resumo
  before_action :set_global_summary_service

  # Carrega o serviço de filmes
  before_action :set_all_film_service, only: %i[index]

  # Busca e exibe os filmes
  def index
    page = params[:page] || 1
    title = params[:q]

    # Verifica se foi informado um título
    if title.present?
      # Busca os filmes pelo título
      @movies = @all_film_service.general(title, page)
      transform_requests_result(@movies)

      # Busca na API caso não encontre os filmes
      if @movies.empty?
        @movies = @all_film_service.general(title, page)
        transform_requests_result(@movies)
      end
    else
      # Busca os filmes sem filtro de título
      @movies = @all_film_service.general(title, page)
      transform_requests_result(@movies)
    end

    # Busca os filmes da próxima página
    @next_movies = @all_film_service.general(title, page.to_i + 1)
    transform_requests_result(@next_movies)
  end

  private

  # Inicializa o serviço de filmes
  def set_all_film_service
    @all_film_service = Request::AllFilm.new
  end

  # Inicializa o serviço de resumo
  def set_global_summary_service
    @summary_service = GlobalSummary.new
  end
  
  def transform_requests_result(movies)
    @movies = MovieTransformer.transform_requests_result(movies)
  end
end
