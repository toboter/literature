class Collection < Subject
  validates :title, :published_date, :creator_list, presence: true
  
  def full_entry(style='harvard')
    "#{creators.order(lname: :asc).map(&:rname).join(', ')}, 
    #{published_date}, 
    #{title} 
    #{subtitle}
    #{has_serie && root? && serie ? serie.abbr+' '+volume+'. ' : ''} 
    #{place.try(:name)}: 
    #{publisher.try(:name)}." 
  end

  def has_serie
    true
  end
  def has_children
    'InCollection'
  end
  def has_parent
    false
  end
  def creator_type
    "Editor"
  end
end