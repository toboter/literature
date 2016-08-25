class Api::V1::CitationsController < ActionController::API

  def index
    render json: Subject.all, each_serializer: CitationSerializer
  end

  def show
    render json: Subject.friendly.find(params[:id]), serializer: CitationSerializer
  end
end
