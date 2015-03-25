require 'rails_helper'

feature 'post an answer', %Q{
  As a user
  I want to answer another user's question
  So that I can help them solve their problem
} do
  # Acceptance Criteria
  # * I must be on the question detail page
  # * I must provide a description that is at least 50 characters long
  # * I must be presented with errors if I fill out the form incorrectly

  scenario 'post an answer' do
    question = Question.create(title: "question" * 40, description: "description" * 150)
    answer = Answer.new(description: "description" * 50, question_id: question.id)

    visit questions_path
    click_link question.title

    fill_in 'Description', with: answer.description
    click_button "Submit Answer"

    expect(page).to have_content(answer.description)
    expect(page).to have_content('Answer was successfully created.')
  end

  scenario 'unsuccessfully post an answer that is too short' do
    question = Question.create(title: "question" * 40, description: "description" * 150)
    answer = Answer.new(description: "description", question_id: question.id)

    visit questions_path
    click_link question.title

    fill_in 'Description', with: answer.description
    click_button "Submit Answer"

    expect(page).to have_content("Description is too short (minimum is 50 characters)")
  end
end
