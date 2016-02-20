require 'rails_helper'

RSpec.describe Api::UsersController, :type => :controller do
  describe "POST #create" do
    context "no access token" do
      it "returns http 201" do
        post :create, format: :json, user: FactoryGirl.attributes_for(:user)
        expect(response.status).to eq(201)
      end

      it "returns correct http body" do
        user_attributes = FactoryGirl.attributes_for(:user)
        post :create, format: :json, user: user_attributes

        resp = JSON.parse(response.body)
        expect(resp.keys).to eq(["id", "email", "created_at", "updated_at", "admin"])
        expect(resp["email"]).to eq(user_attributes[:email])
      end
    end
  end

  describe "GET #me" do
    context "invalid access token" do
      it "returns http 401" do
        get :me
        expect(response.status).to eq(401)
      end
    end

    context "valid access token" do
      before do
        @user = FactoryGirl.create(:user)
        @application = FactoryGirl.create(:oauth_application, owner_id: @user.id, owner_type: User)
        @token = FactoryGirl.create(:oauth_access_token, application: @application, resource_owner_id: @user.id)
      end

      it "returns http 200" do
        get :me, format: :json, access_token: @token.token
        expect(response.status).to eq(200)
      end

      it "returns correct http body" do
        get :me, format: :json, access_token: @token.token
        expect(response.body).to eq(@user.to_json)
      end
    end
  end
end
