class Subject < ApplicationRecord
  extend FriendlyId
  include SearchCop
  
  before_validation :create_url_code, on: :create
  before_validation :create_citation
  after_save :update_citation_sequence  
  
  self.inheritance_column = :type
  friendly_id :url_code #, use: :slugged
  has_closure_tree dependent: :destroy
  acts_as_sequenced scope: :citation, column: :cite_seq_id
  acts_as_taggable
      
  validates :type, :url_code, presence: true
  validates :citation, :uniqueness => { :scope => :cite_seq_id, :message => "This should not happen because of the unique sequence abc etc." }

  
  def self.types
    child_types+parent_types
  end
  def self.child_types
    %w(InBook InCollection InProceeding InJournal InReference)
  end
  def self.parent_types
    %w(Monograph Collection Proceeding Issue Reference Misc)
  end
  def self.has_serie
    %w(Monograph Collection Proceeding Issue Reference)
  end
    
  
  has_many :creatorships, dependent: :destroy
  has_many :creators, through: :creatorships
  belongs_to :place
  belongs_to :publisher
  belongs_to :serie
  has_many :identifiers, dependent: :destroy
  accepts_nested_attributes_for :identifiers, reject_if: :all_blank, allow_destroy: true

  filterrific(
    default_filter_params: { sorted_by: 'published_date_desc' },
    available_filters: [
      :sorted_by,
      :search,
      :with_type
    ]
  )

  #scopes
  search_scope :search do
    attributes :title, :subtitle, :type, :published_date, :cite
    attributes :identifier => ["identifiers.ident_value"]
    attributes :serie => ["serie.abbr", "serie.name"]
    attributes :creator => ["creators.lname", "creators.fname"]
    attributes :tag => "tags.name"

    # attributes :in => ['parent.*']
    # Ideal wäre, wenn auch die parent attribute durchsucht würden.

  end

  scope :with_type, lambda { |types|
    where(type: [*types])
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^title_/
      order("LOWER(subjects.title) #{ direction }")
    when /^published_date_/
      order("LOWER(subjects.published_date) #{ direction }")
    when /^creator_/
      order("LOWER(subjects.cite) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }
   
  def self.options_for_sorted_by
    [
      ['Title (a-z)', 'title_asc'],
      ['Title (z-a)', 'title_desc'],
      ['Published date (newest first)', 'published_date_desc'],
      ['Published date (oldest first)', 'published_date_asc'],
      ['Author or editor (a-z)', 'creator_asc'],
      ['Author or editor (z-a)', 'creator_desc']
    ]
  end

  
  # before filter
  
  def create_citation
    if type == 'Issue' && serie_id
      self.citation = "#{Serie.find(serie_id).abbr} #{volume} (#{published_date})"
    else
      names=[]
      creator_list.split(";").flatten.map do |n|
        names << n.split(',').first.squish
      end
      ct = type == 'Collection' || type == 'Proceeding' ? "(#{names.count > 1 ? creator_type.pluralize : creator_type})" : nil
      names = names.count <= 3 ? names.join(', ') : "#{names.first} et al."
      self.citation = "#{names} #{ct} #{published_date}"
    end
  end

  def update_citation_sequence
    if Subject.where(citation: citation).count > 1
      self.update_columns(cite: "#{citation}#{numeric_to_alph(cite_seq_id)}")
      first_subject = Subject.where(citation: citation, cite_seq_id: 1).first
      first_subject.update_columns(cite: "#{first_subject.citation}#{numeric_to_alph(first_subject.cite_seq_id)}")
    else
      self.update_columns(cite: "#{citation}")
    end

  end
  
  def pages
    (first_page.present? || last_page.present?) ? "#{first_page if first_page.present?}-#{last_page if last_page.present?}" : nil
  end

  # import/export
  
  def creator_list
    creators.map(&:rname).join("; ")
  end
  
  def creator_list=(names)
    self.creators = names.reject { |c| c.empty? }.split(";").flatten.map do |n|
      Creator.where(lname: n.split(',').first.squish, fname: n.split(',').last.squish).first_or_create!
    end
  end

  def publisher=(name)
    self.publisher_id = name.present? ? (Publisher.where(name: name).first_or_create!).id : nil
  end
  
  def place=(name)
    self.place_id = name.present? ? (Place.where(name: name).first_or_create!).id : nil
  end
  
  def serie_name=(name_abbr)
    if name_abbr && name_abbr.include?('#')
      abbr = name_abbr.split('#').first.squish
      name = name_abbr.split('#').last.squish
      self.serie = Serie.where(abbr: abbr, name: name).first_or_create!
    end
  end

  Alpha26 = ("a".."z").to_a
  def numeric_to_alph(value)
    return "" if value.nil? || value < 1
    s, q = "", value
    loop do
      q, r = (q - 1).divmod(26)
      s.prepend(Alpha26[r]) 
      break if q.zero?
    end
    s
  end
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |subject|
        csv << subject.attributes.values_at(*column_names)
      end
    end
  end
  
 
  # defaults
  
  def full_entry(style='harvard')
    'error: not defined'
  end


  protected
  def create_url_code
    self.url_code = loop do
      random_token = SecureRandom.urlsafe_base64(6, false)
      break random_token unless self.class.exists?(url_code: random_token)
    end
  end


end