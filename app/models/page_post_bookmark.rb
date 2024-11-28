class PagePostBookmark < ApplicationRecord
  belongs_to :page_post
  belongs_to :user

  validates :page_post_id, uniqueness: { scope: :user_id }
end
