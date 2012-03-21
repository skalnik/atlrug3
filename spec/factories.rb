FactoryGirl.define do
  factory :user do
    name "Mike Skalnik"
    uid  "12345"
  end

  factory :talk do
    title    "Debugging with Pry"
    duration 30
  end
end
