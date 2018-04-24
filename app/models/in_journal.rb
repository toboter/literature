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
  
  def to_bib
    BibTeX::Entry.new({
      :bibtex_type => 'article',
      :bibtex_key => cite.gsub(/[,()]/ ,""),
      :author => creatorships.order(id: :asc).map{|cs| cs.creator.rname}.join(' and '),
      :title => "#{title} #{subtitle}",
      :year => published_date,
      :pages => "#{pages}#{', '+extra_pages if extra_pages.present?}",
      :note => "#{language}",
      :journal => parent.serie.try(:name),
      :volume => parent.volume,
      :issn => parent.identifiers.where(identifiers: {ident_name: 'ISSN'}).first.try(:ident_value),
      :url => g_canonical_link,
      :abstract => "#{g_description}",
      :keywords => tag_list.join('; ')
    })
  end

end