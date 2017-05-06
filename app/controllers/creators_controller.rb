class CreatorsController < ApplicationController
  before_action :set_creator, only: [:edit, :update, :destroy]
  before_action :authorize

  # GET /creators
  # GET /creators.json
  def index
    @creators = Creator.order(lname: :asc)
  end

  # GET /creators/1/edit
  def edit
  end

  # PATCH/PUT /creators/1
  def update
    respond_to do |format|
      if @creator.update(creator_params)
        format.html { redirect_to creators_url, notice: "Creator was successfully updated." }
        format.js
      else
        format.js
      end
    end
  end

  # DELETE /creators/1
  def destroy
    respond_to do |format|
      if !@creator.subjects.any?
        @creator.destroy
        format.html { redirect_to creators_url, notice: 'Creator was successfully removed.' }
        format.js
      else
        format.html { redirect_to creators_url, alert: 'Creator has subjects. Remove or reassign subjects first before removing.' }
      end
    end
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_creator
      @creator = Creator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def creator_params
      params.require(:creator).permit(:fname, :lname, :reassign_to_id)
    end
end
