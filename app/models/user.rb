class User < ApplicationRecord
  acts_as_paranoid
  has_secure_password
  has_one_attached :profile_image
  has_many :page_managers, dependent: :destroy
  has_many :pages, through: :page_managers, dependent: :destroy
  has_many :page_followers, dependent: :destroy
  has_many :following_pages, through: :page_followers, source: :page, dependent: :destroy
  has_many :page_post_bookmarks, dependent: :destroy
  has_many :official_post_bookmarks, dependent: :destroy

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, length: { minimum: 8 }, allow_blank: true
  validates :name, length: { maximum: 20 }
  validates :background, length: { maximum: 100 }
  validates :bio, length: { maximum: 160 }

  before_create do
    self.name ||= ""
    self.display_name ||= ""
    self.is_admin ||= false
    self.bio ||= ""
    self.background ||= ""
    self.url ||= ""
    self.language ||= "ja"
    self.session_token ||= SecureRandom.alphanumeric(16)
    self.followings_count ||= 0
    self.bookmarks_count ||= 0
  end

  def setup?
    name.present?
  end

  def display_profile_image
    if profile_image.attached?
      profile_image.representation(resize_to_fill: [ 300, 300 ])
    else
      "default_profile_image.png"
    end
  end

  def profile_image_resized
    profile_image.variant(resize_to_fill: [ 64, 64 ]).processed
  end

  def page_manager?(page)
    page_managers.find_by(page_id: page.id)
  end

  def page_follower?(page)
    page_followers.find_by(page_id: page.id)
  end

  def page_post_bookmark?(page_post)
    page_post_bookmarks.find_by(page_post_id: page_post.id)
  end

  def official_post_bookmark?(official_post)
    official_post_bookmarks.find_by(official_post_id: official_post.id)
  end

  def page_review(page)
    page.page_reviews.find_by(user_id: id)
  end
end
