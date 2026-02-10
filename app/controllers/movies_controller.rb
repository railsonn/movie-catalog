class MoviesController < ApplicationController
  before_action :set_global_summary_service

  def index
    page = params[:page] || 1
    @movies = @summary_service.movies(page)
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
    params.require(:movie).permit(:title, :overview, :release_date)
  end
end
