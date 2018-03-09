require 'rails_helper'

# type: :controller tells Rspec to treat the test as a controller
RSpec.describe PostsController, type: :controller do
  # we are nesting posts under topics, so we are creating a parent topic named my_topic
  let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

# when new is invoked a new and unsaved post object is created
  describe "Get new" do
    it "returns http success" do
      get :new, params: { topic_id: my_topic.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, params: { topic_id: my_topic.id }
      expect(response).to render_template :new
    end

    it "instantiates @post" do
      get :new, params: { topic_id: my_topic.id }
      expect(assigns(:post)).not_to be_nil
    end
  end

#when create is invoked, the newly created object stays in the databases
  describe "Post create" do

    it "increases the number of Post by 1" do
      expect{ post :create, params: { topic_id: my_topic.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } } }.to change(Post,:count).by(1)
    end

    it "assigns the new post to @post" do
      post :create, params: { topic_id: my_topic.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
      expect(assigns(:post)).to eq Post.last
    end

    it "redirects to the new post" do
      post :create, params: { topic_id: my_topic.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
      expect(response).to redirect_to [my_topic, Post.last]
    end

  end

  describe "Get show" do
    it "returns http success" do
      # we pass id as a parameter
      get :show, params: { topic_id: my_topic.id, id: my_post.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
     # we expect the response to return the show view using render_template
      get :show, params: { topic_id: my_topic.id, id: my_post.id }
      expect(response).to render_template :show
    end

    it "assigns my_post to @post" do
      get :show, params: { topic_id: my_topic.id, id: my_post.id }
      # post is expected to equal to my_post
      expect(assigns(:post)).to eq(my_post)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, params: { topic_id: my_topic.id, id: my_post.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, params: { topic_id: my_topic.id, id: my_post.id }
      expect(response).to render_template :edit
    end

    it "assigns post to be updated to @post" do
      get :edit, params: { topic_id: my_topic.id, id: my_post.id }

      post_instance = assigns(:post)

      expect(post_instance.id).to eq my_post.id
      expect(post_instance.title).to eq my_post.title
      expect(post_instance.body).to eq my_post.body

    end

  end

  describe "PUT update" do
    it "updates post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, params: { topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body } }

      updated_post = assigns(:post)
      expect(updated_post.id).to eq my_post.id
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
    end

    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, params: { topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body } }
      expect(response).to redirect_to [my_topic, my_post]
    end
  end

  describe "DELETE destroy" do

    it "deletes the post" do
      delete :destroy, params: { topic_id: my_topic.id, id: my_post.id }
      # finds post by id and make sure method removes it by expecting 0 count
      count = Post.where({id: my_post.id}).size
      expect(count).to eq 0
    end

    it "redirects to topic show" do
      delete :destroy, params: { topic_id: my_topic.id, id: my_post.id }
      expect(response).to redirect_to my_topic
    end

  end

end
