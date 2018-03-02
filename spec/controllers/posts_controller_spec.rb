require 'rails_helper'

# type: :controller tells Rspec to treat the test as a controller
RSpec.describe PostsController, type: :controller do
  let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  describe "Post index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_post] to @posts" do
      get :index
      expect(assigns(:posts)).to eq([my_post])
    end
  end

# when new is invoked a new and unsaved post object is created
  describe "Post new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @post" do
      get :new
      expect(assigns(:post)).not_to be_nil
    end
  end

#when create is invoked, the newly created object stays in the databases
  describe "Post create" do

    it "increases the number of Post by 1" do
      expect{ post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph}}}.to change(Post,:count).by(1)
    end

    it "assigns the new post to @post" do
      post :create, params: { post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}
      expect(assigns(:post)).to eq Post.last
    end

    it "redirects to the new post" do
      post :create, params: { post: {title:RandomData.random_sentence, body: RandomData.random_paragraph}}
      expect(response).to redirect_to Post.last
    end

  end

  describe "Post show" do
    it "returns http success" do
      # we pass id as a parameter
      get :show, params: { id: my_post.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
     # we expect the response to return the show view using render_template
      get :show, params: { id: my_post.id }
      expect(response).to render_template :show
    end

    it "assigns my_post to @post" do
      get :show, params: { id: my_post.id }
      # post is expected to equal to my_post
      expect(assigns(:post)).to eq(my_post)
    end
  end

  #
  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
