class CategoriesController < ApplicationController

	def show
		@category=Category.find(params[:id])
    	@show_projects=@category.projects
    end
end
