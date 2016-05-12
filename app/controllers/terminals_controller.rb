class TerminalsController < ApplicationController
  before_action :set_agent
  before_action :set_terminal, only: [:show, :edit, :update, :destroy]

  def new
    @terminal = @agent.terminals.build
  end
  
  def create
    @terminal = @agent.terminals.build terminal_params

    if @terminal.save
      flash[:notice] = 'Terminal has been created.'
      redirect_to [ @agent, @terminal]
    else
      flash.now[:alert] = 'Terminal has not been created.'
      render 'new'
    end
  end

  def edit
  end

  def show
  end

  def update
    if @terminal.update terminal_params
      flash[:notice] = 'Terminal has been updated.'
      redirect_to [ @agent, @terminal ]
    else
      flash.now[:alert] = 'Terminal has not been updated.'
      render 'edit'
    end
  end

  def destroy
    @terminal.destroy
    
    flash[:notice] = 'Terminal has been deleted.'
    redirect_to @agent
  end

private
  def set_agent
    @agent = Agent.find params[:agent_id]
  end

  def set_terminal
    @terminal = @agent.terminals.find params[:id]
  end

  def terminal_params
    params.require(:terminal).permit :id, :name, :city, :address, :tel, :lat, :lng
  end
end
