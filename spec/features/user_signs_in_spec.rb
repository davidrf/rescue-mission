require 'rails_helper'

feature 'post a questions', %Q{
  As a user
  I want to sign in
  So that my questions and answers can be associated to me
} do
  # Acceptance Criteria
  # * I must be able to sign in using either GitHub, Twitter, or Facebook (choose one)

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

  scenario "sign in with github credentials" do
    visit root_path
    click_link "Sign In With GitHub"

    expect(page).to have_content("Signed in as #{user.username}")
    expect(page).to have_link("Sign Out", session_path)

    expect(User.count).to eq(1)
  end
end
