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

  # Transforma os resultados da API em objetos
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
end
