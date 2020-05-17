class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: [:show]


    def index 
      if params[:mission_id] && @mission = Mission.find_by_id(params[:mission_id])
        @messages = @mission.messages
      else
        @error = "That mission does not exist" if params[:mission_id]
        @messages = Message.all
      end
    end

    def show
    end

    def new
      if params[:mission_id] && @mission = Mission.find_by_id(params[:mission_id])
        @message = @mission.messages.build
      else
        @error = "That mission does not exist" if params[:mission_id] 
        @message = Message.new 
      end
    end

    def create 
      @message = current_user.messages.build(message_params)
      if @message.save
        redirect_to messages_path
      else
        render :new
      end
    end

    def destroy
    end

    private

    def message_params
      params.require(:message).permit(:content, :mission_id, :user_id)
    end

    def set_message
      @message = Message.find_by(id: params[:id])
      if !@message
        flash[:message] = "Message was not found"
        redirect_to messages_path
      end
    end

end
