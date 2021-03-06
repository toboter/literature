class Reference < Subject
  validates :title, :published_date, :creator_list, presence: true
  validates :title, uniqueness: { scope: :published_date, message: "Creators title exists." }
  
  def full_entry(style='harvard')
    "#{creatorships.order(id: :asc).map{|cs| cs.creator.rname}.join(', ')},
     #{published_date},
     #{title}
     #{subtitle}
     #{place.try(:name)}
     #{': ' if publisher && place}
     #{publisher.try(:name)}." 
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
    "Editor"
  end

  def to_bib
    nil
  end
end