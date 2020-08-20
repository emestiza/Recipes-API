class RecipeController < ApplicationController

  def index
    @recipe = Recipe.all
    if @recipe.empty?
      render json: {
          "error": "There is no data shown"
      }
    else
      render json: {
          :response => "Successful",
          :data => @recipe
      }
    end
  end

  def create
    @recipe_create = Recipe.new(recipe_params)
    if @recipe_create.save
      render :json => {
          :response => 'successfully created',
          :data => @recipe_create
      }
    else
      render :json => {
          :error => 'cannot save the data'
      }
    end
  end

  def show
    @single_recipe = Recipe.exists?(params[:id])
    if @single_recipe
      render :json => {
          :response => 'Successful',
          :data => Recipe.find(params[:id])
      }
    else
      render :json => {
          :response => 'Record not found'
      }
    end
  end

  def update
    if(@single_recipe_update =  Recipe.find_by_id(params[:id])).present?
      @single_recipe_update.update(recipe_params)
      render :json => {
          :response => 'successfully update the data',
          :data => @single_recipe_update
      }
    else
      render :json => {
          :response => 'cannot update selected record'
      }
    end
  end

  def destroy
    if (@recipe_delete = Recipe.find_by_id(params[:id])).present?
      @recipe_delete.destroy
      render :json => {
          :response => 'successfully delete the record'
      }
    else
      render :json => {
          :response => 'cannot delete the selected record'
      }
    end
  end

  private
  def recipe_params
    params.permit(:category_id, :name, :ingredients)
  end

end
