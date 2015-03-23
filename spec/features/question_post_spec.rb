require 'rails_helper'

feature 'post a questions', %Q{
  As a user
  I want to post a question
  So that I can receive help from others
} do
  # Acceptance Criteria
  # * I must provide a title that is at least 40 characters long
  # * I must provide a description that is at least 150 characters long
  # * I must be presented with errors if I fill out the form incorrectly

  scenario 'post a question' do
    question = Question.new(title: "question" * 40, description: "description" * 150)

    visit questions_path
    click_link "New Question"

    fill_in 'Title', with: question.title
    fill_in 'Description', with: question.description
    click_button "Submit Question"

    expect(page).to have_content('Question was successfully created.')
  end

  scenario 'unsuccessfully post a question with too short a title' do
    question = Question.new(title: "question", description: "description" * 150)

    visit questions_path
    click_link "New Question"

    fill_in 'Title', with: question.title
    fill_in 'Description', with: question.description
    click_button "Submit Question"

    expect(page).to have_content("Title is too short (minimum is 40 characters)")
    expect(page).to_not have_content("Description is too short (minimum is 150 characters)")
  end

  scenario 'unsuccessfully post a question with too short a description' do
    question = Question.new(title: "question" * 40, description: "description")

    visit questions_path
    click_link "New Question"

    fill_in 'Title', with: question.title
    fill_in 'Description', with: question.description
    click_button "Submit Question"

    expect(page).to have_content("Description is too short (minimum is 150 characters)")
  end
end
