class AgentsController < ApplicationController
  before_action :set_agent, only: [:show, :edit, :update]

  def index
    @agents = policy_scope(Agent)
    respond_to do |format|
      format.html
      format.json do
        arr = [ ]
        @agents.each do |agn|
          arr << {
            id: agn.id,
            name: agn.name,
            terminals: agn.terminals.to_a
          }
        end
        render json: arr
        # {  render json: @agents.select([:id, :name]) }
      end
    end
  end

  def show
    authorize @agent, :show?
  end

  def edit
    authorize @agent, :update?
  end

  def update
    authorize @agent, :update?

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
