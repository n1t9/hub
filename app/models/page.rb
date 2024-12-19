class Page < ApplicationRecord
  acts_as_paranoid
  has_one_attached :profile_image
  belongs_to :category
  has_many :page_managers
  has_many :managers, through: :page_managers, source: :user
  has_many :page_followers
  has_many :followers, through: :page_followers, source: :user
  has_many :page_posts
  has_many :page_reviews

  def display_profile_image
    if profile_image.attached?
      profile_image.representation(resize_to_fill: [ 300, 300 ])
    else
      "default_profile_image.png"
    end
  end
end
