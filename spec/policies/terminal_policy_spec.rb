require 'rails_helper'

RSpec.describe TerminalPolicy do
  context 'permissions' do
    subject { TerminalPolicy.new user, terminal }

    let(:user) { FactoryGirl.create :user }
    let(:agent) { FactoryGirl.create :agent }
    let(:terminal) { FactoryGirl.create :terminal, agent_id: agent.id }

    context 'for anonymous users' do
      let(:user) { nil }

      it { should_not permit_action :show }
      it { should_not permit_action :edit }
      it { should_not permit_action :create }
      it { should_not permit_action :destroy }
    end

    context 'for viewers of agent' do
      before do
        assign_role! user, :viewer, agent.class.name.singularize.camelize
      end

      it { should     permit_action :show }
      it { should_not permit_action :edit }
      it { should_not permit_action :create }
      it { should_not permit_action :destroy }
    end

    context 'for editors of agent' do
      before do
        assign_role! user, :editor, agent.class.name.singularize.camelize
      end

      it { should     permit_action :show }
      it { should     permit_action :edit }
      it { should_not permit_action :create }
      it { should_not permit_action :destroy }
    end

    context 'for managers of agent' do
      before do
        assign_role! user, :manager, agent.class.name.singularize.camelize
      end

      it { should permit_action :show }
      it { should permit_action :edit }
      it { should permit_action :create }
      it { should permit_action :destroy }
    end

    context 'for admins' do
      let(:user) { FactoryGirl.create :user, :admin }
      
      it { should permit_action :show }
      it { should permit_action :edit }
      it { should permit_action :create }
      it { should permit_action :destroy }
    end
  end
end
