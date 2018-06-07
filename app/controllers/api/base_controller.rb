module Api
  class BaseController < ::ApplicationController
    protect_from_forgery with: :null_session
    #skip_before_action :verify_authenticity_token

    before_filter :doorkeeper_authorize!
    respond_to :json

    protected
      def current_api_user
        @current_api_user ||= User.find(doorkeeper_token.resource_owner_id)
      end
  end
end
