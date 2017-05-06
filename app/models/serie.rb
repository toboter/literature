class Serie < ApplicationRecord
  has_many :subjects
  
  validates :name, presence: true
  validates_uniqueness_of :name, :abbr

  after_update :ensure_correct_citation
  
  def name_abbr
    "#{abbr ? (abbr) : ''}\##{name}"
  end

  def ensure_correct_citation
    self.subjects.each do |subject|
      citation = subject.create_citation
      subject.update(citation: citation, slug: nil)
    end
  end
end
