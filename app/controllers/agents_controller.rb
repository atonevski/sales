class AgentsController < ApplicationController
  before_action :set_agent, only: [:show, :edit, :update, :destroy]

  def index
    @agents = Agent.all
  end

  def new
    @agent = Agent.new
  end

  def create
    @agent = Agent.new agent_params

    if @agent.save
      flash[:notice] = 'Agent has been created.'
      redirect_to @agent
    else
      flash.now[:alert] = 'Agent has not been created.'
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @agent.update agent_params
      flash[:notice] = 'Agent has been updated.'
      redirect_to @agent
    else
      flash.now[:alert] = 'Agent has not been updated.'
      render 'edit'
    end
  end

  def destroy
    @agent.destroy
    
    flash[:notice] = 'Agent has been deleted.'
    redirect_to agents_path
  end
private

  def agent_params
    params.require(:agent).permit :id, :name
  end

  def set_agent
    @agent = Agent.find params[:id]
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'The agent you were looking for could not be found.'
    redirect_to agents_path
  end
end
