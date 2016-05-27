class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update]

  def index
    # before implementing pundit
    # @games = Game.all

    @games = policy_scope Game
  end

  def show
    authorize @game, :show?
  end

  def new
    @game = Game.new
    authorize @game, :create?
  end

  def create
    @game = Game.new game_params
    authorize @game, :create?

    if @game.save
      flash[:notice] = 'Game has been created.'
      redirect_to @game
    else
      flash.now[:alert] = 'Game has not been created.'
      render 'new'
    end
  end

  def edit
    authorize @game, :update?
  end

  def update
    authorize @game, :update?

    if @game.update game_params
      flash[:notice] = 'Game has been updated.'
      redirect_to @game
    else
      flash.now[:alert] = 'Game has not been updated.'
      render 'edit'
    end
  end

private

  def game_params
    params.require(:game).permit :id, :name, :type, :desc, :price, :parent,
      :volume, :commission
  end

  def set_game
    @game = Game.find params[:id]
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'The game you were looking for could not be found.'
    redirect_to games_path
  end
end
