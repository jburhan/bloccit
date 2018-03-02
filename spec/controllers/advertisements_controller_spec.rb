require 'rails_helper'

RSpec.describe AdvertisementsController, type: :controller do
  let(:our_ads) {Advertisement.create!(title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: RandomData.random_number)}

  describe "Advertisement #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [our_ads] to @advertisements" do
      get :index
      expect(assigns(:advertisements)).to eq([our_ads])
    end
  end

  describe "Advertisement #show" do
    it "returns http success" do
      get :show, params: {id: our_ads.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, params: { id: our_ads.id}
      expect(response).to render_template :show
    end

    it "assigns our_ads to @advertisement" do
      get :show, params: {id: our_ads.id}
      expect(assigns(:advertisement)).to eq(our_ads)
    end
  end

  describe "Advertisement #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @advertisement" do
      get :new
      expect(assigns(:advertisement)).not_to be_nil
    end
  end

  describe "Advertisement #create" do

    it "increases the number of ads by 1" do
      expect{ post :create, params: { advertisement: { title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: RandomData.random_number }}}.to change(Advertisement, :count).by(1)
    end

    it "assigns the new ads to @advertisement" do
      post :create, params: { advertisement: { title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: RandomData.random_number }}
      expect(assigns(:advertisement)).to eq Advertisement.last
    end

    it "redirects to the new ads" do
      post :create, params: { advertisement: { title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: RandomData.random_number }}
      expect(response).to redirect_to Advertisement.last
    end
  end

end
