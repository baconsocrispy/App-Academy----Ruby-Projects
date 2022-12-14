class UsersController < ApplicationController
  
    def index
      render json: User.all
    end
  
    def show
     render json: User.find(params[:id])
    end
    
    def new
      @user = User.new
    end
    def create
      @user = User.new(user_params) 
      if @user.save
        render json: @user
      else
        render json: @user.errors.full_messages
      end
    end
  
    def update
     
    end
  
    def edit
     
    end
  
    def destroy
   
    end

    private
    def user_params
      params.require(:user).permit(:username, :password)
    end
end
