class CategoriesController < ApplicationController
  before_action :set_game
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def show
    authorize @category, :show?
  end

  def new
    @category = @game.categories.build
  end

  def create
    @category = @game.categories.build category_params

    if @category.save
      flash[:notice] = 'Category has been created.'
      redirect_to [ @game, @category]
    else
      flash.now[:alert] = 'Category has not been created.'
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if @category.update category_params
      flash[:notice] = 'Category has been updated.'
      redirect_to [ @game, @category ]
    else
      flash.now[:alert] = 'Category has not been updated.'
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    
    flash[:notice] = 'Category has been deleted.'
    redirect_to @game
  end

private
  def set_game
    @game = Game.find params[:game_id]
  end

  def set_category
    @category = @game.categories.find params[:id]
  end

  def category_params
    params.require(:category).permit :category, :count, :amount, :desc
  end
end
