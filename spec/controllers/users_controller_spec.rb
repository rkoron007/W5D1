require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "renders new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #create" do
    context 'with valid params' do
      it "redirects to users user page" do
        post :create, params:{user: {username:'apple', password:'apple6'}}
        expect(response).to redirect_to(user_url(User.last))
      end

      it "signs user in " do
        post :create, params:{user: {username:'apple', password:'apple6'}}
        expect(session[:session_token]).to eq(User.last.session_token)
      end
    end

    context ' with invalid params' do
      it "renders :new" do
        post :create, params:{user: {username:'apple', password:''}}
        expect(response).to render_template(:new)
      end

      it "flashes errors" do
        post :create, params:{user: {username:'apple', password:''}}
        expect(flash[:errors]).to be_present
      end
    end
  end

  describe "GET #show" do
    it "renders the current user template" do
      get :show
      expect(response).to render_template(:show)
    end
  end

end
