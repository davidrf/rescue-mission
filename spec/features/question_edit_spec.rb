require 'rails_helper'

feature 'edit a question', %Q{
  As a user
  I want to edit a question
  So that I can correct any mistakes or add updates
} do
  # Acceptance Criteria
  # * I must provide valid information
  # * I must be presented with errors if I fill out the form incorrectly
  # * I must be able to get to the edit page from the question details page
  # * I must be signed in
  # * I must be able to delete a question that I posted
  # * I can't delete a question that was posted by another user

  let(:user) { FactoryGirl.create(:user_with_question) }
  let!(:another_user) { FactoryGirl.create(:user_with_question) }

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

  scenario 'edit a question' do
    visit root_path
    click_link "Sign In With GitHub"
    click_link user.questions.first.title
    click_link "Edit Question"
    fill_in 'Title', with: "d" * 40
    fill_in 'Description', with: "e" * 150
    click_button "Submit Question"

    expect(page).to have_content('Question was successfully edited.')
  end

  scenario 'unsuccessfully edit a question with too short a title' do
    visit root_path
    click_link "Sign In With GitHub"
    click_link user.questions.first.title
    click_link "Edit Question"
    fill_in 'Title', with: "d" * 39
    fill_in 'Description', with: "e" * 150
    click_button "Submit Question"

    expect(page).to have_content("Title is too short (minimum is 40 characters)")
  end

  scenario 'unsuccessfully edit a question with too short a description' do
    visit root_path
    click_link "Sign In With GitHub"
    click_link user.questions.first.title
    click_link "Edit Question"
    fill_in 'Title', with: "d" * 40
    fill_in 'Description', with: "e" * 149
    click_button "Submit Question"

    expect(page).to have_content("Description is too short (minimum is 150 characters)")
  end

  scenario 'user who is not question owner cannot edit question' do
    another_user = FactoryGirl.create(:user)
    question = FactoryGirl.create(:question_with_two_answers,
      user: another_user
    )

    visit root_path
    click_link "Sign In With GitHub"
    click_link question.title

    expect(page).to_not have_link('Edit Question')
  end
end
