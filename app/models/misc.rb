class Misc < Subject
  validates :title, :published_date, :creator_list, presence: true
  
  def full_entry(style='harvard')
    "#{creators.order(lname: :asc).map(&:rname).join(', ')}, 
    #{published_date}, #{title}. #{subtitle+'. '}#{child? && parent.root? ? parent.full_entry('abbr')+' '+volume+'. ' : ''} #{place.try(:name)}: #{publisher.try(:name)}" 
  end

  def has_serie
    true
  end
  def has_parent
    false
  end
  def has_children
    true
  end
  def creator_type
    "Author"
  end
end
