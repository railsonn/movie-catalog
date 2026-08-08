class CategoriesController < ApplicationController
  # Carrega o serviço de categorias
  before_action :set_category_film_service, only: %i[index show]

  # Carrega o serviço de resumo
  before_action :set_global_summary_service

  require "ostruct"

  # Lista os gêneros de filmes
  def index
    @movies_genres = @category_film_service.categories_genres
  end

  # Lista os filmes de um gênero pegando o gênero da URL e a página de resultados
  def show
    @genre = params[:genre]
    @page = params[:page] || 1
    @movies = @category_film_service.categories_list_movies(@genre, @page.to_i)
    transform_requests_result(@movies)

    @next_movies = @category_film_service.categories_list_movies(@genre, @page.to_i + 1)
    transform_requests_result(@next_movies)
  end

  private

  # Inicializa o serviço de resumo
  def set_global_summary_service
    @summary_service = GlobalSummary.new
  end

  # Inicializa o serviço de categorias
  def set_category_film_service
    @category_film_service = Request::CategoryFilm.new
  end

  def transform_requests_result(movies)
    @movies = MovieTransformer.transform_requests_result(movies)
  end
end
