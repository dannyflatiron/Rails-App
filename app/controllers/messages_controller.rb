class MessagesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]


    def index 
      if params[:mission_id] && @mission = Mission.find_by_id(params[:mission_id])
        @messages = @mission.messages
      else
        @error = "That mission does not exist" if params[:mission_id]
        @messages = Message.all
      end
    end

    def show
      @message = Message.find_by(id: params[:id])
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

    def edit
      @message = Message.find_by(id: params[:id])
    end
    
    def update
      @message = Message.find_by(id: params[:id])
      if @message.update(message_params)
        redirect_to message_path(@message)
      else
        render :edit
      end
    end

    def destroy
    end

    private

    def message_params
      params.require(:message).permit(:content, :mission_id, :user_id)
    end


end
