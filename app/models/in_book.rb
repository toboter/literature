class InBook < Subject
  validates :title, :published_date, :creator_list, :parent, presence: true
  validates :title, uniqueness: { scope: :published_date, message: "Creators title exists." }
  
  def full_entry(style='harvard')
    "#{creatorships.order(id: :asc).map{|cs| cs.creator.rname}.join(', ')}, 
    #{published_date}, 
    #{title}
    #{subtitle}
    In: #{parent.full_entry}
    #{' ' + pages if pages}."
  end
  
  def has_serie
    false
  end
  def has_children
    false
  end
  def has_parent
    %w(Monograph)
  end
  def creator_type
    "Author"
  end
end