class InJournal < Subject
  validates :title, :published_date, :creator_list, :parent, presence: true # + authors + journal
  # validates :title, uniqueness: { scope: :published_date, message: "Creators title exists." }
  
  def full_entry(style='harvard')
    "#{creatorships.order(id: :asc).map{|cs| cs.creator.rname}.join(', ')}, 
    #{published_date ? published_date : parent.published_date}, 
    #{title} 
    #{subtitle} 
    #{parent.full_entry}
    #{' ' + pages if pages}."
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