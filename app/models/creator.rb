class Creator < ApplicationRecord

  has_many :creatorships
  has_many :subjects, through: :creatorships
  
  validates :fname, :lname, presence: true

  after_update :ensure_correct_citation
  
  def name
    "#{fname} #{lname}"
  end
  def rname
    "#{lname}, #{fname}"
  end
  

  def ensure_correct_citation
    self.subjects.each do |subject|
      citation = subject.create_citation
      subject.update(citation: citation, slug: nil)
    end
  end
end
