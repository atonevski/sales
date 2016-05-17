class Admin::AgentsController < Admin::ApplicationController
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

  def destroy
    @agent = Agent.find params[:id]
    @agent.destroy
    
    flash[:notice] = 'Agent has been deleted.'
    redirect_to agents_path
  end

private
  def agent_params
    params.require(:agent).permit :id, :name
  end
end
