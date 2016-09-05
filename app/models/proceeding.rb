class Proceeding < Subject
  validates :title, :published_date, :creator_list, presence: true
  validates :title, uniqueness: { scope: :published_date, message: "Creators title exists." }
  
  def full_entry(style='harvard')
    "#{creators.order(lname: :asc).map(&:rname).join(', ')}, #{published_date}, #{title}. #{subtitle}. #{place.try(:name)}: #{publisher.try(:name)}" 
  end

  def pages
    page_count.present? ? "#{page_count}" : nil
  end
  
  def has_serie
    true
  end
  def has_parent
    false
  end
  def has_children
    'InProceeding'
  end
  def creator_type
    "Editor"
  end
end