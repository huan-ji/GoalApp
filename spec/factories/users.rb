FactoryGirl.define do
  factory :user do
    username "MyString"
    password "password"

    factory :john do
      username "john"
      password "password1"
    end
  end
end
