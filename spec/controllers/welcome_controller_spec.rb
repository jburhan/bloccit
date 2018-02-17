require 'rails_helper'

#this describes the subject on the spec
RSpec.describe WelcomeController, type: :controller do
  describe "GET index" do
    it "renders the index template" do

      # calls the index method of WelcomeController
      get :index
      #expectation
      expect(response).to render_template("index")
    end

    describe "GET about" do
      it "renders the about template" do
        get :about
        expect(response).to render_template("about")
      end
    end

  end
end
