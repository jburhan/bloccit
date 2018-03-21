require 'rails_helper'

RSpec.describe Question, type: :model do
  #this let method allows us to create a new instance of the post class
  let(:question) { Question.create!(title: "New Question Title", body: "New Question Body", resolved: false)}


  # this test whether post has attributes named title and body. This test
  # whether post will return a non-nil value when post.title and post.body is called
  describe "attributes" do
    it "has title and body attributes" do
      expect(question).to have_attributes(title: "New Question Title", body: "New Question Body", resolved: false)
    end
  end
end
