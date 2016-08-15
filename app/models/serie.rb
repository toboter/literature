class Serie < ApplicationRecord
  has_many :subjects
  
  validates :name, presence: true
  validates_uniqueness_of :name
  
  def name_abbr
    "#{abbr ? (abbr) : ''}\##{name}"
  end
    
end
