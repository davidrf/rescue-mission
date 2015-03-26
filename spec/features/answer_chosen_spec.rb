require 'rails_helper'

feature 'user chooses best answer', %Q{
  As a user
  I want to mark an answer as the best answer
  So that others can quickly find the answer
} do
  # Acceptance Criteria
  # * I must be on the question detail page
  # * I must be able mark an answer as the best
  # * I must see the "best" answer above all other answers in the answer list
  # * I must be signed in
  # * I must be able to edit a question that I posted
  # * I can't edit a question that was posted by another user

  let(:user) { FactoryGirl.create(:user) }

  before :each do
    OmniAuth.config.mock_auth[:github] = {
      "provider" => user.provider,
      "uid" => user.uid,
      "info" => {
        "nickname" => user.username,
        "email" => user.email,
        "name" => user.name
      }
    }
  end

  scenario 'best answer chosen' do
    question = FactoryGirl.create(:question_with_two_answers, user: user)

    visit root_path
    click_link "Sign In With GitHub"
    click_link question.title
    click_link "answer_#{question.answers.last.id}"

    expect(page).to have_selector('ul li:first-child strong',
      text: "Accepted Answer")
    expect(page).to have_selector('ul li:first-child p',
      text: question.answers.last.description)
    expect(page).to_not have_selector('ul li:last-child strong',
      text: "Accepted Answer")
    expect(page).to have_selector('ul li:last-child p',
      text: question.answers.first.description)
  end

  scenario 'best answer cannot be chosen if not signed in' do
    question = FactoryGirl.create(:question_with_two_answers, user: user)

    visit root_path
    click_link question.title

    expect(page).to_not have_link("Accept Answer")
  end

  scenario 'best answer cannot be chosen if not question owner' do
    another_user = FactoryGirl.create(:user)
    question = FactoryGirl.create(:question_with_two_answers,
      user: another_user
    )

    visit root_path
    click_link "Sign In With GitHub"
    click_link question.title

    expect(page).to_not have_link("Accept Answer")
  end
end
