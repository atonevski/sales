class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def new
    @game = Game.new 
  end

  def create
    @game = Game.new game_params

    if @game.save
      flash[:notice] = 'Game has been created.'
      redirect_to @game
    else
      flash.now[:alert] = 'Game has not been created.'
      render 'new'
    end
  end

  def show
    @game = Game.find params[:id]
  end

  private

  def game_params
    params.require(:game).permit :id, :name, :type, :desc, :price, :parent,
      :volume, :commission
  end
end
