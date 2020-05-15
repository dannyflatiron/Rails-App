class MissionsController < ApplicationController

    def index
        @missions = Mission.all
    end

    def new
        @mission = Mission.new
    end

    def create
        @mission = current_user.missions.build(mission_params)
        # @mission.user = current_user
        binding.pry
        if @mission.save 
            redirect_to missions_path
        else
            redirect_to '/'
        end
    end

    private

    def mission_params
        params.require(:mission).permit(:title, :content)
    end
end
