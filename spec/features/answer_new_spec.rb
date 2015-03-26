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
    answer = FactoryGirl.build(:answer)

    visit questions_path
    click_link answer.question.title

    fill_in 'Description', with: answer.description
    click_button "Submit Answer"

    expect(page).to have_content(answer.description)
    expect(page).to have_content('Answer was successfully created.')
  end

  scenario 'unsuccessfully post an answer that is too short' do
    answer = FactoryGirl.build(:answer, description: "too short description")

    visit questions_path
    click_link answer.question.title

    fill_in 'Description', with: answer.description
    click_button "Submit Answer"

    expect(page).to have_content("Description is too short (minimum is 50 characters)")
  end
end
