class CategoryOfficialPost < ApplicationRecord
  belongs_to :official_post
  belongs_to :category

  validates :official_post_id, presence: true
  validates :category_id, presence: true
end
