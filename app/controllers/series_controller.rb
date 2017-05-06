class SeriesController < ApplicationController
  before_action :set_serie, only: [:edit, :update, :destroy]
  before_action :authorize

  # GET /series
  # GET /series.json
  def index
    @series = Serie.order(abbr: :asc)
  end

  # GET /series/1/edit
  def edit
  end

  # PATCH/PUT /series/1
  def update
    respond_to do |format|
      if @serie.update(serie_params)
        format.html { redirect_to series_url, notice: "Serie was successfully updated." }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  # DELETE /series/1
  def destroy
    respond_to do |format|
      if !@serie.subjects.any?
        @serie.destroy
        format.html { redirect_to series_url, notice: 'Serie was successfully deleted.' }
        format.js
      else
        format.html { redirect_to series_url, alert: 'Serie has subjects. Remove or reassign subjects first before deleting.' }
      end
    end
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_serie
      @serie = Serie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def serie_params
      params.require(:serie).permit(:abbr, :name)
    end
end
