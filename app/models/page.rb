class Page < ApplicationRecord
  has_one_attached :profile_image
  has_many :page_users
  has_many :users, through: :page_users
  has_many :page_keywords
  has_many :keywords, through: :page_keywords
  has_many :page_followers
  has_many :followers, through: :page_followers, source: :user

  enum status: { active: 1, inactive: 2 }

  def display_profile_image
    if profile_image.attached?
      profile_image
    else
      "default_profile_image.png"
    end
  end
end
