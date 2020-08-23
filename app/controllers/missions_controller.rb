class MissionsController < ApplicationController
    before_action :authenticate_user!


    def index
      if params[:user_id] && @user = User.find_by_id(params[:user_id])
        @missions = @user.missions.alphabetical_order
      else
        @error = "That user does not exist" if params[:user_id] 
        @missions = Mission.last_updated.includes(:category, :user)
      end    
      missions_search
      missions_filter
    end

    def show
      @mission = Mission.find_by_id(params[:id])
      redirect_to missions_path if !@mission
    end

    def new
      # creating a new mission
      if params[:user_id] && @user = User.find_by_id(params[:user_id])
        # user exists 
        # users/10/mission/new
        @mission = @user.missions.build
      else
        # creating a new mission without attaching it to any user 
        # Mission.all......mission_id = 5 user.id = 
        @mission = Mission.new
      end
      @mission.build_category
    end

    def create
      @mission = current_user.missions.build(mission_params)
      if @mission.save 
        redirect_to missions_path
      else
        render :new
      end
    end

    def edit
      set_mission
      if !@mission || @mission.user != current_user
        flash[:message] = "You do not have authorization to edit this mission"
        redirect_to missions_path  
      end
      @mission.build_category if !@mission.category
    end

    def update
      set_mission
        redirect to missions_path if !@mission || @mission.user != current_user
      if @mission.update(mission_params)
        redirect_to mission_path(@mission)
      end
    end

    def destroy
      set_mission.destroy
      flash[:message] = "Mission was successfully deleted"
      redirect_to user_path(current_user)
    end



    private

    def mission_params
      params.require(:mission).permit(:title, :content, :category_id, category_attributes: [:name])
    end

    def set_mission
      @mission = Mission.find_by(params[:id])
    end

    def missions_search
      @missions = @missions.search(params[:q].downcase) if params[:q] && !params[:q].empty?
    end

    def missions_filter
      @missions = @missions.filter(params[:mission][:category_id]) if params.try(:mission) && params.try(:mission).try(:category_id)
    end
end
