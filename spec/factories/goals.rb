FactoryGirl.define do
  factory :goal do
    description "This is a public goal"
    goal_type "public"
    user_id 1
  end
end
