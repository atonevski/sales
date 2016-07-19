class CommissionLettersController < ApplicationController
  skip_after_action :verify_authorized, :verify_policy_scoped

  def index
    @commission_letters = CommissionLetter.all
  end
end
