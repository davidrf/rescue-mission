FactoryGirl.define do
  factory :question do
    sequence(:title) { |n| n.to_s * 40 }
    description "b" * 150
    user

    factory :question_with_two_answers do
      after(:create) do |question|
        FactoryGirl.create(:answer, question: question)
        FactoryGirl.create(:answer, question: question)
      end
    end
  end

  factory :answer do
    sequence(:description) { |n| n.to_s * 50 }
    question
  end

  factory :user do
    provider "github"
    sequence(:uid) { |n| n.to_s }
    sequence(:username) { |n| "george_michael_#{n}" }
    sequence(:email) { |n| "gm#{n}@example.com" }
    sequence(:name) { |n| "George Michael #{n}" }

    factory :user_with_question do
      after(:create) do |user|
        FactoryGirl.create(:question, user: user)
      end
    end
  end
end
