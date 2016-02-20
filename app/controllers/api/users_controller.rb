module Api
  class UsersController < BaseController
    respond_to :json

    # GET /api/users/me
    def me
      render json: current_api_user
    end
  end
end
