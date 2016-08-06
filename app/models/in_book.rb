class InBook < Subject
  validates :title, :creator_list, presence: true
  
  def full_entry(style='harvard')
    "#{creators.order(lname: :asc).map(&:rname).join(', ')}, 
    #{published_date}, #{title}. #{subtitle}. #{place.try(:name)}: #{publisher.try(:name)}" 
  end

  def has_children
    false
  end
  def has_parent
    %w(Monograph Collection Proceeding)
  end
  def creator_type
    "Author"
  end
end