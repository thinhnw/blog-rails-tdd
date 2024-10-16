require "rails_helper"

RSpec.describe "Pages" do
  let(:user) { create(:user) }

  before do
    login_as(user)
  end

  describe "A new page" do
    it "can be added" do
      visit new_admin_page_path

      select User.last.name, from: "User"
      fill_in "Title", with: "Page Title"
      fill_in "Summary", with: "Summary Info"
      fill_in "Content", with: "Content goes here"
      fill_in "Tags", with: "foo, bar"

      check("Published")

      click_button "Create Page"

      within ".flashes" do
        expected = "Page was successfully created."
        expect(page).to have_css(".flash_notice", text: expected)
      end

      within "#main_content" do
        expect(page).to have_css("td", text: user.name)
        expect(page).to have_css("td", text: "Page Title")
        expect(page).to have_css("td", text: "Summary Info")
        expect(page).to have_css("td", text: "Content goes here")
        expect(page).to have_css("span.yes", text: /yes/i)
        expect(page).to have_css("td", text: "bar, foo")
      end
    end
  end

  describe "An existing page" do
    let(:the_page) { create(:page, :published, user:) }
    let(:user2) { create(:user) }

    before do
      the_page.tags << create(:tag, name: "foo")
      the_page.tags << create(:tag, name: "bar")
      user2
    end

    it "can be edited" do
      visit admin_pages_path

      click_link "Edit"

      expect(page).to have_select("page_user_id", selected: user.name)
      expect(page).to have_field("page_title", with: the_page.title)
      expect(page).to have_field("page_summary", with: the_page.summary)
      expect(page).to have_field("page_content", with: the_page.content)
      expect(page).to have_field("page_tags_string", with: "bar, foo")
      expect(page).to have_checked_field("page_published")

      select user2.name, from: "User"

      fill_in "Title", with: "Page Title"
      fill_in "Summary", with: "Summary Info"
      fill_in "Content", with: "Content goes here"
      fill_in "Tags", with: "foo, bar, baz"

      check("Published")

      click_button("Update Page")

      within ".flashes" do
        text = "Page was successfully updated."
        expect(page).to have_css(".flash_notice", text:)
      end

      within "#main_content" do
        expect(page).to have_css("td", text: user2.name)
        expect(page).to have_css("td", text: "Page Title")
        expect(page).to have_css("td", text: "Summary Info")
        expect(page).to have_css("td", text: "Content goes here")
        expect(page).to have_css("span.yes", text: /yes/i)
        expect(page).to have_css("td", text: "bar, baz, foo")
      end
    end

    it "can be visited", js: true do
      visit admin_pages_path
      within ".index_content" do
        expect(page).to have_css("td", text: the_page.title)
        expect(page).to have_css("td", text: "bar, foo")
        expect(page).to have_css("span.yes", text: /yes/i)

        new_window = window_opened_by do
          click_link "/page/#{the_page.slug}"
        end

        within_window new_window do
          expect(page).to have_css("h2", text: the_page.title)
        end
      end
    end
  end
end
