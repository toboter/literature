class SubjectImportsController < ApplicationController
  load_and_authorize_resource
  
  def new
    @subject_import = SubjectImport.new
  end

  def create
    @subject_import = SubjectImport.new(subject_import_params)
    
    if @subject_import.save
      redirect_to subjects_url, notice: "Imported subjects successfully."
    else
      render :new
    end
  end


  private

  def subject_import_params
    params.require(:subject_import).permit(:file, :title, :subtitle, :type, :parent_id, :first_page, 
        :last_page, :page_count, :volume, :published_date, :abbr, :edition, :language, :publisher, 
        :place, :g_volume_id, :g_canonical_link, :g_image_thumbnail, :serie_name, 
        :creator_list => [],  :tag_list => [], identifiers_attributes: [:id, :ident_name, :ident_value, :_destroy])
  end
end