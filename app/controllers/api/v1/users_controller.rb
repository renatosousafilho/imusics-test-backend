module Api
  module V1
    class UsersController < ApiController
      before_action :doorkeeper_authorize!
      respond_to :json

      def me
      end

      def following
        render json: { artists: current_resource_owner.artists.order(:name) }
      end
    end
  end
end
