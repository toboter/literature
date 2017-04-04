class InCollection < Subject
  validates :title, :published_date, :creator_list, :parent, presence: true
  validates :title, uniqueness: { scope: :published_date, message: "Title exists." }
  
  def full_entry(style='harvard')
    "#{creatorships.order(id: :asc).map{|cs| cs.creator.rname}.join(', ')} 
    (#{published_date ? published_date : parent.published_date}).
     #{title} #{subtitle} In: #{parent.full_entry} #{pages}."
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
    %w(Collection)
  end
  def creator_type
    "Author"
  end

end