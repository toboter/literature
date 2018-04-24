class InReference < Subject
  validates :title, :published_date, :creator_list, :parent, presence: true
  validates :title, uniqueness: { scope: :published_date, message: "Creators title exists." }
  
  def full_entry(style='harvard')
    "#{creatorships.order(id: :asc).map{|cs| cs.creator.rname}.join(', ')}, 
    #{published_date ? published_date : parent.published_date},
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
    %w(Reference)
  end
  def creator_type
    "Author"
  end

  def to_bib
    BibTeX::Entry.new({
      :bibtex_type => type.demodulize.downcase.to_sym,
      :bibtex_key => bibtex_citation,
      :author => authors.map{ |a| a.name(reverse: true) }.join(' and '),
      :title => title,
      :journal => journal.try(:name),
      :year => year,
      :month => month,
      :volume => volume,
      :number => number,
      :pages => pages,
      :note => note,
      :url => url,
      :doi => doi,
      :abstract => abstract,
      :keywords => tag_list.join('; ')
    })
  end


  def to_bib
    BibTeX::Entry.new({
      :bibtex_type => 'incollection',
      :bibtex_key => cite.gsub(/[,()]/ ,""),
      :author => creatorships.order(id: :asc).map{|cs| cs.creator.rname}.join(' and '),
      :title => "#{title} #{subtitle}",
      :booktitle => parent.try(:title),
      :editor => parent.creatorships.order(id: :asc).map{|cs| cs.creator.rname}.join(' and '),
      :year => published_date,
      :publisher => parent.publisher.try(:name),
      :address => parent.place.try(:name),
      :series => parent.serie.try(:name),
      :volume => parent.volume,
      :pages => "#{pages}#{', '+extra_pages if extra_pages.present?}",
      :note => "#{language}",
      :isbn => parent.identifiers.where(identifiers: {ident_name: 'ISBN'}).first.try(:ident_value),
      :url => g_canonical_link,
      :abstract => "#{g_description}",
      :keywords => tag_list.join('; ')
    })
  end
end