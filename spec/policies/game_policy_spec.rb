require 'rails_helper'

RSpec.describe GamePolicy do
  subject { described_class }

  permissions :show? do
    let(:user) { FactoryGirl.create :user }
    let(:game) { FactoryGirl.create :game }

    it 'blocks anonymous users' do
      expect(subject).not_to permit(nil, game)
    end

    it 'allows viewers of the games' do
      assign_role! user, :viewer, game.class.name.singularize.camelize
      
      expect(subject).to permit(user, game)
    end

    it 'allows editors of the games' do
      assign_role! user, :editor, game.class.name.singularize.camelize
      expect(subject).to permit(user, game)
    end

    it 'allows managers of the games' do
      assign_role! user, :manager, game.class.name.singularize.camelize
      expect(subject).to permit(user, game)
    end

    it 'allows administrators' do
      admin = FactoryGirl.create :user, :admin

      expect(subject).to permit(admin, game)
    end
  end


#   permissions ".scope" do
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
