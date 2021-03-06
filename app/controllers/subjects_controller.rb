class SubjectsController < ApplicationController
  before_action :set_type, except: :new

  load_and_authorize_resource
  skip_load_resource only: :index
  skip_authorize_resource only: :index

  # GET /subjects
  # GET /subjects.json
  def index
    @filterrific = initialize_filterrific(
      Subject.visible_for(current_user),
      params[:filterrific],
      select_options: {
        sorted_by: Subject.options_for_sorted_by
      }
    ) or return
    @subjects = @filterrific.find.page(params[:page]).per_page(session[:per_page]).eager_load(:creators, :publisher, :place)
    
    respond_to do |format|
      format.html
      format.js
      format.csv { 
        send_data(
          @filterrific.find.to_csv,
          disposition: "attachment; filename=literature.csv",
          type: 'text/csv',
          stream: 'true', 
          buffer_size: '4096' 
        )
       }
      format.xls { render locals: { subjects: @filterrific.find.eager_load(:creators, :publisher, :place, :identifiers, :parent) }}
      format.bibtex { render text: (BibTeX::Bibliography.new << @filterrific.find.map(&:to_bib)) }
    end
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
  end

  # GET /subjects/new
  def new 
    @creators = Creator.all
    if params[:parent_id]
      parent = Subject.find(params[:parent_id])
      @type = parent.has_children
      @subject = @type.constantize.new
      @subject.parent = parent
    else
      set_type
      @subject = type_class.new
    end
  end

  # GET /subjects/1/edit
  def edit
    @creators = Creator.all
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(type.underscore.to_sym).permit(:title, :subtitle, :type, :parent_id, :first_page, 
        :last_page, :page_count, :volume, :published_date, :abbr, :edition, :language, :publisher, 
        :place, :g_volume_id, :g_canonical_link, :g_image_thumbnail, :serie_name, :extra_pages,
        :creator_list => [], :tag_list => [], identifiers_attributes: [:id, :ident_name, :ident_value, :_destroy],
        comments_attributes: [:id, :body, :_destroy])
    end
end