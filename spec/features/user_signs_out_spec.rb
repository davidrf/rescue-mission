require 'rails_helper'

feature 'user signs outs', %Q{
  As a user
  I want to be able to sign out
  So that other users of my computer can't pretend to be me
} do
  # Acceptance Criteria
  # * I must be able to sign out from any page

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

  scenario "sign out" do
    visit root_path
    click_link "Sign In With GitHub"

    expect(page).to have_content("Signed in as #{user.username}")

    click_link "Sign Out"

    expect(page).to_not have_content("Signed in as #{user.username}")
    expect(page).to have_content("Signed out successfully.")
  end
end
