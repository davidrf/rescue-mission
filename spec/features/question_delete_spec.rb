require 'rails_helper'

feature 'view question details', %Q{
  As a user
  I want to delete a question
  So that I can delete duplicate questions
} do
  # Acceptance Criteria
  # * I must be able delete a question from the question edit page
  # * I must be able delete a question from the question details page
  # * All answers associated with the question must also be deleted
  scenario 'visitor deletes question from details page' do
    question = Question.create(title: "question" * 40, description: "description" * 150)
    answer = Answer.create(description: "description" * 150, question_id: question.id)

    visit questions_path
    click_link(question.title)
    click_link 'Delete Question'

    expect(page).to have_content('Question was successfully deleted.')
    expect(page).to_not have_content(question.title)
    expect(Answer.exists?(answer.id)).to be(false)
  end

  scenario 'visitor deletes question from edit page' do
    question = Question.create(title: "question" * 40, description: "description" * 150)
    answer = Answer.create(description: "description" * 150, question_id: question.id)

    visit questions_path
    click_link(question.title)
    click_link 'Edit Question'
    click_link 'Delete Question'

    expect(page).to have_content('Question was successfully deleted.')
    expect(page).to_not have_content(question.title)
    expect(Answer.exists?(answer.id)).to be(false)
  end
end
