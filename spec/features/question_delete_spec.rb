require 'rails_helper'

feature 'user deletes a question', %Q{
  As a user
  I want to delete a question
  So that I can delete duplicate questions
} do
  # Acceptance Criteria
  # * I must be signed in
  # * I must be able to delete a question that I posted
  # * I can't delete a question that was posted by another user
  # * I must be able delete a question from the question edit page
  # * I must be able delete a question from the question details page
  # * All answers associated with the question must also be deleted

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

  scenario 'question owner deletes question from details page' do
    question = FactoryGirl.create(:question_with_two_answers, user: user)

    visit root_path
    click_link "Sign In With GitHub"
    click_link question.title
    click_link 'Delete Question'

    expect(page).to have_content('Question was successfully deleted.')
    expect(page).to_not have_content(question.title)
    expect(Answer.count).to be(0)
  end

  scenario 'question owner deletes question from edit page' do
    question = FactoryGirl.create(:question_with_two_answers, user: user)

    visit root_path
    click_link "Sign In With GitHub"
    click_link question.title
    click_link 'Edit Question'
    click_link 'Delete Question'

    expect(page).to have_content('Question was successfully deleted.')
    expect(page).to_not have_content(question.title)
    expect(Answer.count).to be(0)
  end

  scenario 'user not signed in cannot delete question' do
    question = FactoryGirl.create(:question_with_two_answers, user: user)

    visit root_path
    click_link question.title

    expect(page).to_not have_link('Edit Question')
    expect(page).to_not have_link('Delete Question')
  end

  scenario 'user who is not question owner cannot delete question' do
    another_user = FactoryGirl.create(:user)
    question = FactoryGirl.create(:question_with_two_answers,
      user: another_user
    )

    visit root_path
    click_link "Sign In With GitHub"
    click_link question.title

    expect(page).to_not have_link('Edit Question')
    expect(page).to_not have_link('Delete Question')
  end
end
