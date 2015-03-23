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

  scenario 'visitor views all questions in order, most recently posted first' do
    question1 = Question.create(title: "question1" * 40, description: "description" * 150)
    question2 = Question.create(title: "question2" * 40, description: "description" * 150)
    answer1 = Answer.create(description: "answer1" * 50, question_id: question1.id)
    answer2 = Answer.create(description: "answer2" * 50, question_id: question1.id)
    answer3 = Answer.create(description: "answer3" * 50, question_id: question2.id)

    visit questions_path
    click_link question1.title

    expect(page).to have_content(answer1.description)
    expect(page).to have_selector('ul li:first-child', text: answer1.description)
    expect(page).to have_selector('ul li:last-child', text: answer2.description)
    expect(page).to_not have_content(answer3.description)
  end
end
