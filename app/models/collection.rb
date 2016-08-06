class Collection < Subject
  validates :title, :published_date, :creator_list, presence: true
  
  def full_entry(style='harvard')
    "#{creators.order(lname: :asc).map(&:rname).join(', ')}, 
    #{published_date}, #{title}. #{subtitle}. #{place.try(:name)}: #{publisher.try(:name)}" 
  end

  def has_children
    %w(InCollection)
  end
  def has_parent
    %w(Serial)
  end
  def creator_type
    "Editor"
  end
end