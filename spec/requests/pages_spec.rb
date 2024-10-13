require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET a single page" do
    let(:page) { create(:page, :published) }
    it "returns http success" do
      get page_path(slug: page.slug)
      expect(response).to have_http_status(:success)
    end
  end
end
