class Subject < ApplicationRecord
  extend FriendlyId
  
  self.inheritance_column = :type
  
  validates :type, presence: true
  
  has_many :creatorships, dependent: :destroy
  has_many :creators, through: :creatorships
  belongs_to :place
  belongs_to :publisher
  has_many :identifiers, dependent: :destroy
  accepts_nested_attributes_for :identifiers, reject_if: :all_blank, allow_destroy: true
  
  has_closure_tree
  accepts_nested_attributes_for :children, reject_if: :all_blank, allow_destroy: true
  
  friendly_id :code, use: :slugged # slug field: By default, this field must be named :slug, though you may change this using the slug_column configuration option. You should add an index to this column, and in most cases, make it unique. You may also wish to constrain it to NOT NULL, but this depends on your app's behavior 
  
  def self.types
    %w(Monograph InBook Collection InCollection Proceeding InProceeding Journal Issue InJournal Reference InReference Misc Serial)
  end
  scope :monographs, -> { where(type: 'Monograph') } 
  
  scope :by_creator, -> lname, fname { joins(:creators).where('creators.lname = ? AND creators.fname = ?', lname, fname) if fname && lname }

  def self.search(q)
    if q
      key = "%#{q}%"
      joins(:creators).where('title LIKE :search OR subtitle LIKE :search OR published_date LIKE :search OR creators.lname LIKE :search OR creators.fname LIKE :search', search: key)
    else
      all
    end
  end
  
  
  def code
    Digest::SHA1.hexdigest self.published_date # und authors und index
  end
  
  def creator_list
    creators.map(&:name).join(", ")
  end
  
  def creator_list=(names)
    self.creators = names.reject { |c| c.empty? }.split(",").flatten.map do |n|
      Creator.where(lname: n.split(' ').last, fname: n.split(' ').first).first_or_create!
    end
  end

  def publisher=(name)
    self.publisher_id = name.present? ? (Publisher.where(name: name).first_or_create!).id : nil
  end
  
  def place=(name)
    self.place_id = name.present? ? (Place.where(name: name).first_or_create!).id : nil
  end
  
  def cite
    names = creators.count <= 3 ? creators.order(lname: :asc).limit(3).map(&:lname).join(', ') : "#{creators.order(lname: :asc).first.lname} et al." 
    "#{names} #{published_date}"
  end
 
 
 # defaults
  def full_entry(style='harvard')
    'error: not defined'
  end
  def has_children
    false
  end
  def has_parent
    false
  end
  def creator_type
    "Creator"
  end
  def full_title
    "#{title} : #{subtitle}"
  end
end