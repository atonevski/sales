class Admin::RolesController < ApplicationController
  skip_after_action :verify_authorized, :verify_policy_scoped

  before_action :set_role, only: [:show, :edit, :update, :destroy]

  def index
    @roles = policy_scope Role
  end

  def show
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new role_params

    if @role.save
      flash[:notice] = 'Role has been created.'
      redirect_to admin_roles_path
    else
      flash.now[:alert] = 'Role has not been created.'
      render 'new'
    end
  end


private
  def role_params
    params.require(:role).permit :id, :user_id, :role, :model
  end

  def set_role
    @role = Role.find params[:id]
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'The role you were looking for could not be found.'
    redirect_to admin_root_path
  end
end
