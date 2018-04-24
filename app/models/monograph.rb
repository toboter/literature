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

  def to_bib
    BibTeX::Entry.new({
      :bibtex_type => 'book',
      :bibtex_key => cite.gsub(/[,()]/ ,""),
      :author => creatorships.order(id: :asc).map{|cs| cs.creator.rname}.join(' and '),
      :title => "#{title} #{subtitle}",
      :publisher => publisher.try(:name),
      :year => published_date,
      :address => place.try(:name),
      :series => serie.try(:name),
      :volume => volume,
      :edition => edition,
      :note => "#{language}",
      :isbn => identifiers.where(identifiers: {ident_name: 'ISBN'}).first.try(:ident_value),
      :url => g_canonical_link,
      :abstract => "#{g_description}",
      :keywords => tag_list.join('; ')
    })
  end
end


# Barker, R., Kirk, J. and Munday, R.J., 1988. Narrative analysis. 3rd ed. Bloomington: Indiana University Press.

# Allouche, Jose. ed., 2006. Corporate social resposibility, Volume 1: concepts, accountability and reporting. Basingstoke: Palgrave Macmillan.