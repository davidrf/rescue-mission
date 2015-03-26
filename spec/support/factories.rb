FactoryGirl.define do
  factory :question do
    title "a" * 40
    description "b" * 150
  end

  factory :answer do
    description "c" * 50
    question
  end

  factory :user do
    provider "github"
    sequence(:uid) { |n| n.to_s }
    sequence(:username) { |n| "george_michael_#{n}" }
    sequence(:email) { |n| "gm#{n}@example.com" }
    sequence(:name) { |n| "George Michael #{n}" }
  end
end
