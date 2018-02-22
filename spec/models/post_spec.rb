require 'rails_helper'

RSpec.describe Post, type: :model do
  #this let method allows us to create a new instance of the post class
  let(:post) { Post.create!(title: "New Post Title", body: "New Post Body")}


  # this test whether post has attributes named title and body. This test
  # whether post will return a non-nil value when post.title and post.body is called
  describe "attributes" do
    it "has title and body attributes" do
      expect(post).to have_attributes(title: "New Post Title", body: "New Post Body")
    end
  end
end
