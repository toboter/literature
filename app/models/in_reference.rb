class InReference < Subject
  validates :title, :creator_list, presence: true

  def full_entry(style='harvard')
    "#{creators.order(lname: :asc).map(&:rname).join(', ')}, 
    #{published_date ? published_date : parent.published_date}, #{title} #{subtitle+'. '} in: #{parent.full_entry}"
  end

  def has_serie
    false
  end
  def has_children
    false
  end
  def has_parent
    %w(Reference)
  end
  def creator_type
    "Author"
  end
end