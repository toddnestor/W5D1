require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it "renders the new user page" do
      get :new

      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context "with valid params" do
      it "creates a new user" do
        post :create, user: {username: "travis", password: "asdfasdf"}
        expect(response).to redirect_to(user_url(User.find_by_username("travis")))
      end
    end

    context "with invalid params" do
      it "does not create a new user" do
        post :create, user: {username: "whatever"}
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end
  end

  describe 'GET #show' do
    context "with invalid id" do
      it "does not show a user page" do
        begin
          get :show, id: -1
        rescue
          ActiveRecord::RecordNotFound
        end

        expect(response).not_to render_template("show")
      end
    end

    context "with valid id" do
      it "renders the user page" do
        FactoryGirl.create(:user)
        get :show, id: User.last.id

        expect(response).to render_template("show")
      end
    end
  end
end
