class Issue < Subject
  validates :volume, :published_date, :serie_id, presence: true
  
  def full_entry(style='harvard')
    "#{serie.abbr} #{volume} #{published_date}"
    # "#{creators.order(lname: :asc).map(&:rname).join(', ')}, 
    #{published_date}, #{title}. #{subtitle+'. '}#{child? && parent.root? ? parent.full_entry('abbr')+' '+volume+'. ' : ''} #{place.try(:name)}: #{publisher.try(:name)}" 
  end

  def has_serie
    true
  end
  def has_parent
    false
  end
  def has_children
    'InJournal'
  end
  def creator_type
    "Editor"
  end
end