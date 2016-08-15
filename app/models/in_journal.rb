class InJournal < Subject
  validates :title, :published_date, presence: true # + authors + journal

  def full_entry(style='harvard')
    "#{creators.order(lname: :asc).map(&:rname).join(', ')}, 
    #{published_date ? published_date : parent.published_date}, #{title} #{subtitle ? subtitle+'. ' : ''} in: #{parent.full_entry}"
  end

  def has_serie
    false
  end
  def has_children
    false
  end
  def has_parent
    %w(Issue)
  end
  def creator_type
    "Author"
  end
  
end