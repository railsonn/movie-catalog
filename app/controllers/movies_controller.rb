class MoviesController < ApplicationController
  require "ostruct"
  before_action :set_global_summary_service

  def index
    page = params[:page] || 1
    @movies = @summary_service.movies(page)
    transform_requests_result(@movies)
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


  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to @movie, notice: "Filme criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, notice: "Filme removido com sucesso."
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Filme atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def new
    @movie = Movie.new
  end

  def edit
  end




  private

  def set_global_summary_service
    @summary_service = GlobalSummary.new
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :type, :year, :poster, :imdbID)
  end
end
