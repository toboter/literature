class Place < ApplicationRecord
  has_many :subjects
  
  validates :name, presence: true
  validates_uniqueness_of :name
end
