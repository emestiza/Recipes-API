class CategoryController < ApplicationController
  before_action :authorized
  
  def index
    @category = Category.all
    if @category.empty?
      render json: {
          "error": "There is no data shown"
      }
    else
      render json: {
          :response => "Successful",
          :data => @category
      }
    end
  end

  def create
    @category_create = Category.new(category_params)
    if @category_create.save
      render :json => {
          :response => 'successfully created',
          :data => @category_create
      }
    else
      render :json => {
          :error => 'cannot save the data'
      }
    end
  end

  def show
    @single_category = Category.exists?(params[:id])
    if @single_category
      render :json => {
          :response => 'Successful',
          :data => Category.find(params[:id])
      }
    else
      render :json => {
          :response => 'Record not found'
      }
    end
  end

  def update
    if(@single_category_update =  Category.find_by_id(params[:id])).present?
      @single_category_update.update(category_params)
      render :json => {
          :response => 'successfully update the data',
          :data => @single_category_update
      }
    else
      render :json => {
          :response => 'cannot update selected record'
      }
    end
  end

  def destroy
    if (@category_delete = Category.find_by_id(params[:id])).present?
      @category_delete.destroy
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
  def category_params
    params.permit(:id, :title, :description, :created_by)
  end

end
