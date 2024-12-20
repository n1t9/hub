class OfficialPostBookmark < ApplicationRecord
  belongs_to :official_post
  belongs_to :user

  validates :official_post_id, uniqueness: { scope: :user_id }
end
