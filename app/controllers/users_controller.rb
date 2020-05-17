class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

    def new
    end

    def create
    end

    def show
      @user = User.find(params[:id])
    end


    private
    
    def user_params
      params.require(:user).permit(:name, :email, :uid, :encrypted_password, :provider )
    end
end
