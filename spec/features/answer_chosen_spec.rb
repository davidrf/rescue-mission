require 'rails_helper'

feature 'best answer chosen', %Q{
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

  scenario 'post an answer' do
    answer = FactoryGirl.create(:answer)
    another_answer = FactoryGirl.create(:answer, question_id: answer.question.id)
    visit questions_path
    click_link answer.question.title
    click_link "answer_#{answer.id}"
    expect(page).to have_selector('ul li:first-child strong', text: "Accepted Answer")
    expect(page).to have_selector('ul li:first-child p', text: answer.description)
  end
end
