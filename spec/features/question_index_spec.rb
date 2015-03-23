require 'rails_helper'

feature 'view all questions', %Q{
  As a user
  I want to view recently posted questions
  So that I can help others
} do
  # Acceptance Criteria
  # * I must see the title of each question
  # * I must see questions listed in order, most recently posted first

  scenario 'visitor views all questions in order, most recently posted first' do
    question1 = Question.create(title: "question1" * 40, description: "description" * 150)
    question2 = Question.create(title: "question2" * 40, description: "description" * 150)
    visit questions_path

    expect(page).to have_selector('ul li:first-child a', text: "question2" * 40)
    expect(page).to have_selector('ul li:last-child a', text: "question1" * 40)
  end
end
