module Api
  class UsersController < BaseController
    skip_before_filter :doorkeeper_authorize!, only: [:create]

    # POST /api/users
    def create
      user = User.new(user_params)

      if user.save
        render json: user, status: 201
      else
        render json: user.errors, status: 422
      end
    end

    # GET /api/users/me
    def me
      render json: current_api_user
    end

    protected
      def user_params
        params.require(:user).permit(:email, :password)
      end
  end
end
