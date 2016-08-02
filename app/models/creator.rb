class Creator < ApplicationRecord
  has_many :creatorships
  has_many :subjects, through: :creatorships
  
  validates :fname, :lname, presence: true
  
  def name
    "#{fname} #{lname}"
  end
  def rname
    "#{lname}, #{fname}"
  end
  
end
