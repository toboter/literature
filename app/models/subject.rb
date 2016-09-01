class Subject < ApplicationRecord
  extend FriendlyId
  include SearchCop
  
  before_validation :create_url_code
  before_validation :create_citation
  after_save :update_citation_sequence
  
  self.inheritance_column = :type
  
  validates :type, presence: true
  validates :citation, :uniqueness => { :scope => :cite_seq_id, :message => "check against cite seq missing" }
  
  has_many :creatorships, dependent: :destroy
  has_many :creators, through: :creatorships
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  belongs_to :place
  belongs_to :publisher
  belongs_to :serie
  has_many :identifiers, dependent: :destroy
  accepts_nested_attributes_for :identifiers, reject_if: :all_blank, allow_destroy: true
  
  has_closure_tree
  
  friendly_id :friendly_url, use: :slugged 
  def should_generate_new_friendly_id?
    citation_changed?
  end
  def friendly_url
    "#{citation} #{url_code}".parameterize
  end
  
  
  def create_citation
    if type == 'Issue' && serie_id
      self.citation = "#{Serie.find(serie_id).abbr} #{volume} #{published_date}"
    else
    names=[]
    creator_list.split(",").flatten.map do |n|
      names << n.split(' ').last
    end
      names = names.count <= 3 ? names.join(' ') : "#{names.first} et al."
      self.citation = "#{names} #{published_date}"
    end
  end
  acts_as_sequenced scope: :citation, column: :cite_seq_id
  
  def update_citation_sequence
    if Subject.where(citation: citation).count > 1
      self.update_columns(cite: "#{citation}#{numeric_to_alph(cite_seq_id)}")
      first_subject = Subject.where(citation: citation, cite_seq_id: 1).first
      first_subject.update_columns(cite: "#{first_subject.citation}#{numeric_to_alph(first_subject.cite_seq_id)}")
    else
      self.update_columns(cite: "#{citation}")
    end

  end
  
  def self.types
    child_types+parent_types
  end
  def self.child_types
    %w(InBook InCollection InProceeding InJournal InReference)
  end
  def self.parent_types
    %w(Monograph Collection  Proceeding  Issue  Reference  Misc)
  end
  def self.has_serie
    %w(Monograph Collection  Proceeding  Issue  Reference)
  end

  search_scope :search do
    attributes :title, :subtitle, :type, :published_date, :cite
    attributes :identifier => ["identifiers.ident_value"]
    attributes :serie => ["serie.abbr", "serie.name"]
    attributes :creator => ["creators.lname", "creators.fname"]
    attributes :tag => "tags.name"
  end
  
  
  def creator_list
    creators.map(&:name).join(", ")
  end
  
  def creator_list=(names)
    self.creators = names.reject { |c| c.empty? }.split(",").flatten.map do |n|
      Creator.where(lname: n.split(' ').last, fname: n.split(' ').first).first_or_create!
    end
  end

  def tag_list
    tags.map(&:name).join(", ")
  end
  
  def tag_list=(names)
    self.tags = names.reject { |c| c.empty? }.split(",").flatten.map do |n|
      Tag.where(name: n).first_or_create!
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

 
 # defaults
  def full_entry(style='harvard')
    'error: not defined'
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

  protected
  def create_url_code
    self.url_code = loop do
      random_token = SecureRandom.urlsafe_base64(6, false)
      break random_token unless self.class.exists?(url_code: random_token)
    end
  end


end