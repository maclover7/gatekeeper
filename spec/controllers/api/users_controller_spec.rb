require 'rails_helper'

RSpec.describe Api::UsersController, :type => :controller do
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
