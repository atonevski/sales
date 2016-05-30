require 'rails_helper'

RSpec.describe CategoryPolicy do
  context 'permissions' do
    subject { CategoryPolicy.new user, category }

    let(:user) { FactoryGirl.create :user }
    let(:game) { FactoryGirl.create :game }
    let(:category) { FactoryGirl.create :category, game_id: game.id }

    context 'for anonymous users' do
      let(:user) { nil }

      it { should_not permit_action :show }
      it { should_not permit_action :edit }
      it { should_not permit_action :create }
      it { should_not permit_action :destroy }
    end

    context 'for viewers of game' do
      before do
        assign_role! user, :viewer, game.class.name.singularize.camelize
      end

      it { should     permit_action :show }
      it { should_not permit_action :edit }
      it { should_not permit_action :create }
      it { should_not permit_action :destroy }
    end

    context 'for editors of game' do
      before do
        assign_role! user, :editor, game.class.name.singularize.camelize
      end

      it { should     permit_action :show }
      it { should     permit_action :edit }
      it { should_not permit_action :create }
      it { should_not permit_action :destroy }
    end

    context 'for managers of game' do
      before do
        assign_role! user, :manager, game.class.name.singularize.camelize
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

#   let(:user) { User.new }
# 
#   subject { described_class }
# 
#   permissions ".scope" do
#     pending "add some examples to (or delete) #{__FILE__}"
#   end
# 
#   permissions :show? do
#     pending "add some examples to (or delete) #{__FILE__}"
#   end
# 
#   permissions :create? do
#     pending "add some examples to (or delete) #{__FILE__}"
#   end
# 
#   permissions :update? do
#     pending "add some examples to (or delete) #{__FILE__}"
#   end
# 
#   permissions :destroy? do
#     pending "add some examples to (or delete) #{__FILE__}"
#   end
end
