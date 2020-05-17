class MissionsController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]


    def index
      if params[:user_id] && @user = User.find_by_id(params[:user_id])
        @missions = @user.missions.alphabetical_order
      else
        @error = "That user does not exist" if params[:user_id] 
        @missions = Mission.date_created.includes(:category, :user)
      end    
      @missions = @missions.search(params[:q].downcase) if params[:q] && !params[:q].empty?
      @missions = @missions.filter(params[:mission][:category_id]) if params.try(:mission) && params.try(:mission).try(:category_id)
      
    end

    def show
      @mission = Mission.find_by_id(params[:id])
      redirect_to missions_path if !@mission
    end

    def new
      if params[:user_id] && @user = User.find_by_id(params[:user_id])
        @mission = @user.missions.build
      else
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
      @mission = Mission.find_by(params[:id])
      redirect to missions_path if !@mission || @mission.user != current_user
      @mission.build_category if !@mission.category
    end

    def update
      @mission = Mission.find_by(params[:id])
      redirect to missions_path if !@mission || @mission.user != current_user
      if @mission.update(mission_params)
        redirect_to mission_path(@mission)
      end
    end

    def destroy
      Mission.find_by(params[:id]).destroy
      redirect_to user_path(current_user)
    end



    private

    def mission_params
      params.require(:mission).permit(:title, :content, :category_id, category_attributes: [:name])
    end
end
