class Collection < Subject
  validates :title, :published_date, :creator_list, presence: true
  validates :title, uniqueness: { scope: :published_date, message: "Creators title exists." }
  
  def full_entry(style='harvard')
    "#{creatorships.order(id: :asc).map{|cs| cs.creator.rname}.join(', ')}
    (#{published_date}).
    #{title} 
    #{subtitle}
    #{has_serie && root? && serie ? (serie.abbr.present? ? serie.abbr+' '+volume+'. ' : "[#{serie.name}] #{volume}.") : ''}
    #{place.try(:name)}
    #{': ' if place && publisher}
    #{publisher.try(:name)}."
  end

  def pages
    page_count.present? ? "#{page_count}" : nil
  end
  
  def has_serie
    true
  end
  def has_children
    'InCollection'
  end
  def has_parent
    false
  end
  def creator_type
    "Editor"
  end
end