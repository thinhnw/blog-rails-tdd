require "rails_helper"
RSpec.describe "Home" do
  it "renders homepages" do
    visit root_path
    within "header" do
      expect(page).to have_link "My Blog"
    end
  end
end
