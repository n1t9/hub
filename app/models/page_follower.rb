class PageFollower < ActiveRecord::Base
  belongs_to :page
  belongs_to :user

  validates :page_id, uniqueness: { scope: :user_id }
end
