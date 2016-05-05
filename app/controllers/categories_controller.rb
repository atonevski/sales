class CategoriesController < ApplicationController
  before_action :set_game
  def new
    @category = @game.categories.build
  end

private
  def set_game
    @game = Game.find params[:game_id]
  end
end
