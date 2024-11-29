class OfficialPostBookmark < ApplicationRecord
  belongs_to :user
  belongs_to :official_post

  validates :official_post_id, uniqueness: { scope: :user_id }
end
