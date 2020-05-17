class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

    def new
    end

    def create
    end

    def show
      @user = User.find(params[:id])
    end

    def message
      @receiver = User.find_by(id: params[:id])
      @sender = current_user
      @message = params[:content]

      #send an email
      send_coded_message(@receiver, @sender, @message)
      redirect_to users_path
    end


    private
    
    def user_params
      params.require(:user).permit(:name, :email, :uid, :encrypted_password, :provider )
    end
end
