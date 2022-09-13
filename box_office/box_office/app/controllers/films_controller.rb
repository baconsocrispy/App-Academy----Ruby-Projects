class FilmsController < ApplicationController
  
    def index
      render json: Film.all
    end
  
    def show
     render json: Film.find_by(id: params[:id])
    end
  
    def create
      @film = Film.new(film_params)
      if @film.save 
        render json: @film 
      else 
        @film.errors.full_messages
      end
    end
  
    def update
      @film = Film.find_by(id: params[:id])
      @film.update(film_params)
      if @film.save
        render json: @film
      else
        @film.errors_full_messages
      end
    end
  
    def edit
      # Renders view for update
    end
    def new
      # renders view for create
    end
  
    def destroy
      @film = Film.find_by(id: params[:id])
      @film.destroy
      render json: @film
    end
    private
    def film_params
      params.require(:film).permit(:title)
    end
end
