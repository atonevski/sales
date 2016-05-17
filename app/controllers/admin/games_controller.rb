class Admin::GamesController < Admin::ApplicationController
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

  def destroy
    @game = Game.find params[:id]
    @game.destroy
    
    flash[:notice] = 'Game has been deleted.'
    redirect_to games_path
  end

private
  def game_params
    params.require(:game).permit :id, :name, :type, :desc, :price, :parent,
      :volume, :commission
  end
end
