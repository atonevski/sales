FactoryGirl.define do
  factory :role do
    model 'Game'
    trait :viewer do 
      user_id 2
      role :viewer
    end
    trait :editor  do 
      user_id 3
      role :editor
    end
    trait :manager do
      user_id 4
      role :manager
    end
  end
end
