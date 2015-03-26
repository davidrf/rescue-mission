require "rails_helper"

feature "guest creates account" do

  before :each do
    # This suppresses any warnings from polluting the test output.
    # http://stackoverflow.com/questions/19483367/rails-omniauth-error-in-rspec-output
    OmniAuth.config.logger = Logger.new("/dev/null")
  end

  scenario "successful sign up with valid github credentials" do
    OmniAuth.config.mock_auth[:github] = {
      "provider" => "github",
      "uid" => "123456",
      "info" => {
        "nickname" => "boblob",
        "email" => "bob@example.com",
        "name" => "Bob Loblaw"
      }
    }

    visit root_path

    click_link "Sign In With GitHub"

    expect(page).to have_content("Signed in as boblob")
    expect(page).to have_link("Sign Out", session_path)

    expect(User.count).to eq(1)
  end

  scenario "failure to sign up with invalid credentials" do
    OmniAuth.config.mock_auth[:github] = :invalid_credentials

    visit root_path

    click_link "Sign In With GitHub"

    expect(page).to have_content("Unable to sign in.")
    expect(page).to have_link("Sign In With GitHub", new_session_path)
    expect(User.count).to eq(0)
  end

end
