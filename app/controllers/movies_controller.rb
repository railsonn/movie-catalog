class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @genre_name = @movies.map do |movie|
      movie.genres.first.name
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

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date)
  end
end
