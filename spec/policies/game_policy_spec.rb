require 'rails_helper'

RSpec.describe GamePolicy do
  context 'permissions' do
    subject { GamePolicy.new user, game }

    let(:user) { FactoryGirl.create :user }
    let(:game) { FactoryGirl.create :game }

    context 'for anonymous users' do
      let(:user) { nil }
      
      it { should_not permit_action :show }
      it { should_not permit_action :update }
      it { should_not permit_action :create }
    end

    context 'for viewers of the game' do
      before do
        assign_role! user, :viewer, game.class.name.singularize.camelize
      end

      it { should     permit_action :show }
      it { should_not permit_action :update }
      it { should_not permit_action :create }
    end

    context 'for editors of the game' do
      before do
        assign_role! user, :editor, game.class.name.singularize.camelize
      end

      it { should     permit_action :show }
      it { should     permit_action :update }
      it { should_not permit_action :create }
    end

    context 'for managers of the game' do 
      before do
        assign_role! user, :manager, game.class.name.singularize.camelize
      end

      it { should permit_action :show }
      it { should permit_action :update }
      it { should permit_action :create }
    end

    context 'for administrators' do
      let(:user) { FactoryGirl.create :user, :admin }

      it { should permit_action :show }
      it { should permit_action :update }
      it { should permit_action :create }
    end
  end

  # subject { described_class }

  # permissions :show? do
  #   let(:user) { FactoryGirl.create :user }
  #   let(:game) { FactoryGirl.create :game }

  #   it 'blocks anonymous users' do
  #     expect(subject).not_to permit(nil, game)
  #   end

  #   it 'allows viewers of the games' do
  #     assign_role! user, :viewer, game.class.name.singularize.camelize
  #     
  #     expect(subject).to permit(user, game)
  #   end

  #   it 'allows editors of the games' do
  #     assign_role! user, :editor, game.class.name.singularize.camelize
  #     expect(subject).to permit(user, game)
  #   end

  #   it 'allows managers of the games' do
  #     assign_role! user, :manager, game.class.name.singularize.camelize
  #     expect(subject).to permit(user, game)
  #   end

  #   it 'allows administrators' do
  #     admin = FactoryGirl.create :user, :admin

  #     expect(subject).to permit(admin, game)
  #   end
  # end

  # permissions :update? do
  #   
  #   let(:user) { FactoryGirl.create :user }
  #   let(:game) { FactoryGirl.create :game }

  #   it 'blocks anonymous users' do
  #     expect(subject).not_to permit(nil, game)
  #   end

  #   it "doesn't allow viewers of the games" do
  #     assign_role! user, :viewer, game.class.name.singularize.camelize
  #     
  #     expect(subject).not_to permit(user, game)
  #   end
  #   
  #   it 'allows editors of the games' do
  #     assign_role! user, :editor, game.class.name.singularize.camelize
  #     expect(subject).to permit(user, game)
  #   end

  #   it 'allows managers of the games' do
  #     assign_role! user, :manager, game.class.name.singularize.camelize
  #     expect(subject).to permit(user, game)
  #   end

  #   it 'allows administrators' do
  #     admin = FactoryGirl.create :user, :admin

  #     expect(subject).to permit(admin, game)
  #   end
  # end

  context 'policy_scope' do
    subject { Pundit.policy_scope user, Game }

    let!(:game) { FactoryGirl.create :game }
    let(:user) { FactoryGirl.create :user }
    let(:admin) { FactoryGirl.create :user, :admin }

    it 'is empty for anonymous users' do
      expect(Pundit.policy_scope(nil, Game)).to be_empty
    end
    
    it 'returns all games for users with permissions' do
      assign_role! user, :viewer, 'Game'
      expect(subject).to include(game)
    end

    it 'returns all games for admins' do
      assign_role! user, :viewer, 'Game'
      expect(Pundit.policy_scope(admin, Game)).to include(game)
    end
  end

end
