require 'rails_helper'

feature 'post a questions', %Q{
  As a user
  I want to write my questions and answers with markdown
  So I can easily format my questions and answers
} do
  # Acceptance Criteria
  # * I can write my questions and answers using markdown syntax
  # * Questions and answers, when shown, should be the HTML rendered from the markdown

  scenario 'post a question with markdown' do
    description = 'description' * 150
    question = Question.new(title: 'question' * 40, description: "**#{description}**")

    visit questions_path
    click_link "New Question"

    fill_in 'Title', with: question.title
    fill_in 'Description', with: question.description
    click_button "Submit Question"

    expect(page).to have_selector('p strong', text: description)
  end

  scenario 'post an answer with markdown' do
    description = 'description' * 50
    question = Question.create(title: "question" * 40, description: "description" * 150)
    answer = Answer.new(description: "**#{description}**", question_id: question.id)

    visit questions_path
    click_link question.title

    fill_in 'Description', with: answer.description
    click_button "Submit Answer"

    expect(page).to have_selector('ul li:last-child p strong', text: description)
  end
end
