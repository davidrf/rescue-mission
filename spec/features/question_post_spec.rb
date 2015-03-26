require 'rails_helper'

feature 'post a questions', %Q{
  As a user
  I want to post a question
  So that I can receive help from others
} do
  # Acceptance Criteria
  # * I must be signed in
  # * I must provide a title that is at least 40 characters long
  # * I must provide a description that is at least 150 characters long
  # * I must be presented with errors if I fill out the form incorrectly

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

  scenario 'post a question' do
    question = FactoryGirl.build(:question)

    visit root_path
    click_link "Sign In With GitHub"
    click_link "New Question"

    fill_in 'Title', with: question.title
    fill_in 'Description', with: question.description
    click_button "Submit Question"

    expect(page).to have_content('Question was successfully created.')
  end

  scenario 'unsuccessfully post a question with too short a title' do
    question = FactoryGirl.build(:question, title: "too short title")

    visit root_path
    click_link "Sign In With GitHub"
    click_link "New Question"

    fill_in 'Title', with: question.title
    fill_in 'Description', with: question.description
    click_button "Submit Question"

    expect(page).to have_content("Title is too short (minimum is 40 characters)")
  end

  scenario 'unsuccessfully post a question with too short a description' do
    question = FactoryGirl.build(:question,
      description: "too short description"
    )

    visit root_path
    click_link "Sign In With GitHub"
    click_link "New Question"

    fill_in 'Title', with: question.title
    fill_in 'Description', with: question.description
    click_button "Submit Question"

    expect(page).to have_content("Description is too short (minimum is 150 characters)")
  end

  scenario 'unsuccessfully post a question because not signed in' do
    question = FactoryGirl.build(:question)

    visit root_path
    click_link "New Question"

    fill_in 'Title', with: question.title
    fill_in 'Description', with: question.description
    click_button "Submit Question"

    expect(page).to have_content("Please sign in")
  end
end
