class ArtworksController < ApplicationController
  def index
    artist_id = params[:user_id]
    render json: Artwork.find_by_user(artist_id)
  end
  def create
    art = Artwork.create(artwork_params)
    if art.save
      render json: art
    else
      render json: art.errors.full_messages, status: :unprocessable_entity
    end
  end
  def update
    art = Artwork.find(params[:id])
    art.update_attributes(artwork_params)
    if art.save
      render json: art
    else
      render json: art.errors.full_messages, status: :unprocessable_entity
    end
  end
  def show
    render json: Artwork.find(params[:id])
  end
  def destroy
    art = Artwork.find(params[:id])
    art.destroy
    render json: art
  end

  private
  def artwork_params
    params.require(:artwork).permit(:title, :image_url, :artist_id)
  end
end