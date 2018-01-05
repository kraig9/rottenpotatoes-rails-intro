class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings=Movie.maturity
    
    if params[:ratings].nil?
        @check_ratings = session[:ratings]
      else
        @check_ratings = params[:ratings].keys
    end
    @movies=Movie.where({rating: @check_ratings})
    
    if params[:sort].nil?
      @check_sort=session[:sort]
    else
      @check_sort=params[:sort]
    end
    
    if @check_sort == 'title'
      @movies=@movies.order(:title)
      @hilite = 'title'
    elsif @check_sort=='date'
      @movies = @movies.order(:release_date)
      @hilite = 'release_date'
    end
    session[:ratings]=@check_ratings
    session[:sort]=@check_sort
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
