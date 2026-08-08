class MoviesController < ApplicationController
  require "ostruct"

  # Carrega o serviço de resumo
  before_action :set_global_summary_service, :set_all_film_service, only: %i[index], :transform_requests_result

  # Lista os filmes
  def index
    page = params[:page] || 1
    @movies = @summary_service.movies(page)
    transform_requests_result(@movies)

    @next_movies = @summary_service.movies(page.to_i + 1)
    transform_requests_result(@next_movies)
  end

  # Transforma os resultados da API em objetos
  @movies = MovieTransformer.transform_requests_result(@movies)


  # Transforma o resultado de um filme específico, método usado na busca por id na acão show
  def transform_request_result_search_id(movie)
    base_url = "https://image.tmdb.org/t/p/w500"
    poster_path = movie["poster_path"]
    poster_url = "#{base_url}#{poster_path}"

    @movie = [OpenStruct.new(
      title: movie["original_title"],
      year: movie["release_date"],
      poster: poster_url,
      vote_average: movie["vote_average"],
      adult: movie["adult"],
      overview: movie["overview"],
      id_movie: movie["id"]
    )]
  end

  # Cria um novo filme
  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to @movie, notice: "Filme criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Remove um filme
  def destroy
    @movie.destroy
    redirect_to movies_path, notice: "Filme removido com sucesso."
  end

  # Atualiza um filme
  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Filme atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Exibe um filme específico
  def show
    @movie_id = params[:id] || 0

    unless @movie_id == 0
      @movie = @find_film_service.find(@movie_id.to_i)
    end

    transform_request_result_search_id(@movie)
  end

  # Exibe o formulário de criação
  def new
    @movie = Movie.new
  end

  private
  
  # Inicializa o serviço de resumo
  def set_global_summary_service
    @summary_service = GlobalSummary.new
  end

  # Inicializa o serviço de busca de filmes
  def set_find_film_service
    @find_film_service = Request::FindFilm.new
  end

  # transforma os resultados da API em objetos
  def transform_requests_result(movies)
    @movies = MovieTransformer.transform_requests_result(movies)
  end
end
