class CommissionsController < ApplicationController
  skip_after_action :verify_authorized, :verify_policy_scoped

  def index
    
  end
end
