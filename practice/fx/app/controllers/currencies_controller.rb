class CurrenciesController < ApplicationController
  
    def index
      @currencies = Currency.all
      render :index
    end
  
    def show
      @currency = Currency.find_by(id: params[:id])
      render :show
    end
  
    def create
      
    end
  
    def update

    end
  
    def edit

    end
  
    def destroy

    end

    def new

    end
    private
    def currency_params
      params.require(:currency).permit(:name, :rate, :code)
    end
end