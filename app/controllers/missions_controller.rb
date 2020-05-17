class MissionsController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]


    def index
      if params[:user_id] && @user = User.find_by_id(params[:user_id])
        @missions = @user.missions.alphabetical_order
      else
        @error = "That user does not exist" if params[:user_id] 
        @missions = Mission.all.alphabetical_order
      end    
    end

    def new
      if params[:user_id] && @user = User.find_by_id(params[:user_id])
        @mission = @user.missions.build
      else
        @mission = Mission.new
      end
    end

    def create
      @mission = current_user.missions.build(mission_params)
      if @mission.save 
        redirect_to missions_path
      else
        render :new
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
