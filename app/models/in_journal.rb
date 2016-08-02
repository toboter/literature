class InJournal < Subject
  validates :title, :published_date, presence: true # + authors + journal
end