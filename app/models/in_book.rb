class InBook < Subject
  validates :title, :published_date, :creator_list, :parent, presence: true
  validates :title, uniqueness: { scope: :published_date, message: "Creators title exists." }
  
  def full_entry(style='harvard')
    "#{creators.order(lname: :asc).map(&:rname).join(', ')}, 
    #{published_date}, #{title}. #{subtitle}. #{place.try(:name)}: #{publisher.try(:name)}" 
  end
  
  def pages
    first_page.present? && last_page.present? ? "#{first_page}-#{last_page}" : ''
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