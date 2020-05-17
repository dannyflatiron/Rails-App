class CategoriesController < ApplicationController

    def index
        @categories = Category.all.includes(:posts)
    end

    def show 
        @category = Category.find_by_id(params[:id])
    end

    # def new
    #   if params[:user_id] && @user = User.find_by_id(params[:user_id])
    #     @category= @user.categories.build
    #   else
    #     @category= Category.new
    #   end
    # end

    # def create
    #   @category = current_user.categories.build(category_params)
    #   if @category.save 
    #     redirect_to categories_path
    #   else
    #     render :new
    #   end
    # end

    # private

    # def message_params
    #     params.require(:category).permit(:content)
    #   end

end
