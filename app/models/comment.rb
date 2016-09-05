class Comment < ApplicationRecord
  belongs_to :subject
  validates :body, presence: true
end
