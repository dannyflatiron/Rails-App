class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
      if !@user || @user.id != current_user.id
        flash[:message] = "You do not have authorization to view this Agent's account"
        redirect_to users_path  
      end
    end

    def message
      @receiver = User.find_by(id: params[:id])
      @sender = current_user
      @message = params[:content]

      #send an email
      email = EncodedMessageMailer.send_coded_message(@receiver, @sender, @message)
      email.deliver_now
      redirect_to users_path
    end


    private
    
    def user_params
      params.require(:user).permit(:name, :email, :uid, :encrypted_password, :provider )
    end
end
