require 'rails_helper'

feature 'view all answers for a given question', %Q{
  As a user
  I want to view the answers for a question
  So that I can learn from the answer
} do
  # Acceptance Criteria
  # * I must be on the question detail page
  # * I must only see answers to the question I'm viewing
  # * I must see all answers listed in order, most recent last

  scenario 'view answers for a question in order, most recent first' do
    question = FactoryGirl.create(:question_with_two_answers)
    another_question = FactoryGirl.create(:question_with_two_answers)

    visit questions_path
    click_link question.title

    expect(page).to have_selector('ul li:first-child',
      text: question.answers.first.description)
    expect(page).to have_selector('ul li:last-child',
      text: question.answers.last.description)
    expect(page).to_not have_content(another_question.answers.first.description)
    expect(page).to_not have_content(another_question.answers.last.description)
  end
end
