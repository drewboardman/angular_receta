class RecipesController < ApplicationController
  def index
    @recipes = if params[:keywords]
                 Recipe.where(Recipe
                   .arel_table[:name]
                   .matches("%#{params[:keywords]}%"))
               else
                 []
               end
  end
end
