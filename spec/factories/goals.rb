FactoryGirl.define do
  factory :goal do
    description Faker::Hipster.sentence
    user_id 1
  end
end
