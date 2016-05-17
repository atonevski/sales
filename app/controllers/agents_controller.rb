class AgentsController < ApplicationController
  before_action :set_agent, only: [:show, :edit, :update]

  def index
    @agents = Agent.all
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
