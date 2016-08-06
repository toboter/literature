class Serial < Subject
  validates :title, presence: true
  
  def full_entry(style='harvard')
    "#{creators.order(lname: :asc).map(&:rname).join(', ')}, 
    #{published_date}, #{title}. #{subtitle}. #{place.try(:name)}: #{publisher.try(:name)}" 
  end

  def has_children
    %w(Monograph Collection Proceeding)
  end
  def has_parent
    false
  end
  def creator_type
    "Editor"
  end
end