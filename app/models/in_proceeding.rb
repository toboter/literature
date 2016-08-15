class InProceeding < Subject
  validates :title, :creator_list, presence: true
  
  def full_entry(style='harvard')
    "#{creators.order(lname: :asc).map(&:rname).join(', ')}, 
    #{published_date ? published_date : parent.published_date}, #{title}. #{subtitle+'. '}#{parent.place.try(:name)}: #{parent.publisher.try(:name)}" 
  end

  def has_serie
    false
  end
  def has_children
    false
  end
  def has_parent
    %w(Proceeding)
  end
  def creator_type
    "Author"
  end
end