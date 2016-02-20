module Api
  class UsersController < BaseController
    skip_before_filter :doorkeeper_authorize!, only: [:create]

    # POST /api/users
    def create
      user = User.new(user_params)

      if user.save
        oauth_app = Doorkeeper::Application.find_by_uid(params[:application_id])
        token = Doorkeeper::AccessToken.create!(application_id: oauth_app.id, resource_owner_id: user.id)

        render json: user.as_json.merge(access_token: token.token), status: 201
      else
        render json: user.errors, status: 422
      end
    end

    # GET /api/users/me
    def me
      render json: current_api_user
    end

    # PUT /api/users/me
    def update
      current_api_user.update(user_params)

      if current_api_user.save
        render json: current_api_user, status: 200
      else
        render json: current_api_user.errors, status: 422
      end
    end

    protected
      def user_params
        params.require(:user).permit(:email, :password)
      end
  end
end
