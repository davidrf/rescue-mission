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
