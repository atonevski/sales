class CommissionsController < ApplicationController
  skip_after_action :verify_authorized, :verify_policy_scoped

  def index
  end

  def show
   @agent = Agent.find params[:id] 
   @terminals = @agent.terminals
   @months = Sale.distinct.select('substr(date, 1, 7) AS ym')
              .where(agent_id: 225).where('sales > 0.0').order('ym ASC')
  end

  def create
    @from     = params[:from]
    @to       = params[:to]
    @agent_id = params[:agent_id]

    render 'calc'
  end
end
