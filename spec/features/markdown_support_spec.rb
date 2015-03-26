require 'rails_helper'

feature 'post questions and answers with markdown', %Q{
  As a user
  I want to write my questions and answers with markdown
  So I can easily format my questions and answers
} do
  # Acceptance Criteria
  # * I can write my questions and answers using markdown syntax
  # * Questions and answers, when shown, should be the HTML rendered from the markdown

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

  scenario 'post a question with markdown' do
    description = 'description' * 150
    markdown_description = "**#{description}**"
    question = FactoryGirl.build(:question)
    question.description = markdown_description

    visit root_path
    click_link "Sign In With GitHub"
    click_link "New Question"

    fill_in 'Title', with: question.title
    fill_in 'Description', with: question.description
    click_button "Submit Question"

    expect(page).to have_selector('p strong', text: description)
  end

  scenario 'post an answer with markdown' do
    description = 'description' * 150
    markdown_description = "**#{description}**"
    question = FactoryGirl.create(:question, user: user)
    answer = FactoryGirl.build(:answer, description: markdown_description)

    visit questions_path
    click_link question.title

    fill_in 'Description', with: answer.description
    click_button "Submit Answer"

    expect(page).to have_selector('ul li:last-child p strong', text: description)
  end
end
