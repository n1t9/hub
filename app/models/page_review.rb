class PageReview < ApplicationRecord
  belongs_to :page
  belongs_to :user

  validates :content, presence: true, length: { maximum: 160 }
end
