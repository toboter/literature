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

  def to_bib
    BibTeX::Entry.new({
      :bibtex_type => 'collection',
      :bibtex_key => cite.gsub(/[,()]/ ,""),
      :editor => creatorships.order(id: :asc).map{|cs| cs.creator.rname}.join(' and '),
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