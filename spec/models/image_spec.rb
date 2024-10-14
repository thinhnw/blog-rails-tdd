require 'rails_helper'

RSpec.describe Image, type: :model do
  it { should validate_presence_of(:name) }

  describe "has a valid factory" do
    it { expect(build(:image)).to be_valid }
  end
end
