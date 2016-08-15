class Proceeding < Subject
  validates :title, :published_date, :creator_list, presence: true # authors, publisher
  
  def full_entry(style='harvard')
    "#{creators.order(lname: :asc).map(&:rname).join(', ')}, #{published_date}, #{title}. #{subtitle}. #{place.try(:name)}: #{publisher.try(:name)}" 
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