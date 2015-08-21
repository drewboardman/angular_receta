class RecipesController < ApplicationController
  def index
    @recipes = if params[:keywords]
                 Recipe.where("name ILIKE ?","%#{params[:keywords]}%")
               else
                 []
               end
  end
end
