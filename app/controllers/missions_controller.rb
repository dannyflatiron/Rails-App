class MissionsController < ApplicationController
    skip_before_action :authenticate_user!, except: [:show, :index]

    def index
       
    end

    def index
      if params[:mission_id] && @mission = Mission.find_by_id(params[:mission_id])
        @message = @mission.messages.build
      else
        @error = "That mission does not exist" if params[:mission_id] 
        @message = Message.new 
      end    
    end

    def new
      @mission = Mission.new
    end

    def create
      @mission = current_user.missions.build(mission_params)
      # @mission.user = current_user
      if @mission.save 
        redirect_to missions_path
      else
        redirect_to '/'
      end
    end

    def show
      @mission = Mission.find_by_id(params[:id])
      redirect_to missions_path if !@mission
    end

    private

    def mission_params
      params.require(:mission).permit(:title, :content)
    end
end
