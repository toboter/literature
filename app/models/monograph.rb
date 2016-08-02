class Monograph < Subject
  validates :title, :published_date, presence: true # authors, publisher
end