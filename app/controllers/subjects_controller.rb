class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  before_action :set_type

  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = type_class.order(published_date: :asc)
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
  end

  # GET /subjects/new
  def new
    @subject = type_class.new
  end

  # GET /subjects/1/edit
  def edit
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(subject_params)

    respond_to do |format|
      if @subject.save
        format.html { redirect_to @subject, notice: "#{type} was successfully created." }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to @subject, notice: "#{type} was successfully updated." }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_type
      @type = type
    end
    
    def type
      Subject.types.include?(params[:type]) ? params[:type] : "Subject"
    end
    
    def type_class
      type.constantize
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = type_class.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(type.underscore.to_sym).permit(:title, :subtitle, :type, :parent_id, :first_page, :last_page, :page_count, :volume, :published_date, :abbr, :edition, :language, :publisher, :place, :g_volume_id, :g_canonical_link, :g_image_thumbnail, :creator_list => [])
    end
end


# creatorships_attributes: [:subject_id, :creator_id, :poistion, :type, creatorship_creators_attributes: [:fname, :lname]]