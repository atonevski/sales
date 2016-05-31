require 'rails_helper'

RSpec.describe AgentPolicy do
  context 'permissions' do
    subject { AgentPolicy.new user, agent }

    let(:user) { FactoryGirl.create :user }
    let(:agent) { FactoryGirl.create :agent }

    
    context 'for anonymous users' do
      let(:user) { nil }

      it { should_not permit_action :show }
      it { should_not permit_action :update }
      it { should_not permit_action :create }
    end

    context 'for viewers of Agent model' do
      before { assign_role! user, :viewer, 'Agent' }

      it { should     permit_action :show }
      it { should_not permit_action :update }
      it { should_not permit_action :create }
    end

    context 'for editors of Agent model' do
      before { assign_role! user, :editor, 'Agent' }

      it { should     permit_action :show }
      it { should     permit_action :update }
      it { should_not permit_action :create }
    end

    context 'for managers of Agent model' do
      before { assign_role! user, :manager, 'Agent' }

      it { should permit_action :show }
      it { should permit_action :update }
      it { should permit_action :create }
    end

    context 'for admins' do
      let(:user) { FactoryGirl.create :user, :admin }

      it { should permit_action :show }
      it { should permit_action :update }
      it { should permit_action :create }
    end

  end
end
