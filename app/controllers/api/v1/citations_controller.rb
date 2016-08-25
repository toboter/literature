module Api
  module V1
    class CitationsController < ActionController::API

      def index
        render json: Subject.all
      end

      def show
        render json: Subject.friendly.find(params[:id])
      end

    end
  end
end