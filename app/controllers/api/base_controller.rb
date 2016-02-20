module Api
  class BaseController < ::ApplicationController
    before_filter :doorkeeper_authorize!
    respond_to :json

    protected
      def current_api_user
        @current_api_user ||= User.find(doorkeeper_token.resource_owner_id)
      end
  end
end
