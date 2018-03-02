require 'rails_helper'

RSpec.describe Advertisements, type: :model do
  let(:advertisement) {Advertisement.create!(title: "New Advertisement Body",copy: "New Advertisement Body", price: 00000 )}

  describe "advertisement attributes" do
    it "has title, copy, and price attributes " do
      expect(advertisement).to have_attributes(title: "New Advertisement Body",copy: "New Advertisement Body", price: 00000 )
    end
  end
end
