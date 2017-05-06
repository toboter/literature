class Monograph < Subject
  validates :title, :published_date, :creator_list, presence: true
  validates :title, uniqueness: { scope: :published_date, message: "Creators title exists." }
  
  
  def full_entry(style='harvard')
    "#{creatorships.order(id: :asc).map{|cs| cs.creator.rname}.join(', ')}, 
    #{published_date}, 
    #{title} 
    #{subtitle}
    #{has_serie && serie ? (serie.abbr.present? ? serie.abbr+' '+volume+'. ' : "[#{serie.name}] #{volume}") : ''} 
    #{place.try(:name)}
    #{': ' if publisher && place}
    #{publisher.try(:name)}." 
  end

  def pages
    page_count.present? ? "#{page_count}" : nil
  end
  
  def has_serie
    true
  end
  def has_parent
    false
  end
  def has_children
    'InBook'
  end
  def creator_type
    "Author"
  end
end


# Barker, R., Kirk, J. and Munday, R.J., 1988. Narrative analysis. 3rd ed. Bloomington: Indiana University Press.

# Allouche, Jose. ed., 2006. Corporate social resposibility, Volume 1: concepts, accountability and reporting. Basingstoke: Palgrave Macmillan.