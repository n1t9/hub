class User < ApplicationRecord
  has_secure_password
  has_one_attached :profile_image
  has_many :page_users, dependent: :destroy
  has_many :pages, through: :page_users, dependent: :destroy
  has_many :page_followers, dependent: :destroy
  has_many :following_pages, through: :page_followers, source: :page, dependent: :destroy
  has_many :page_post_bookmarks, dependent: :destroy
  has_many :official_post_bookmarks, dependent: :destroy

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password_digest, presence: true
  validates :name, length: { maximum: 20 }
  validates :background, length: { maximum: 100 }
  validates :bio, length: { maximum: 160 }

  def initialize(attributes = {})
    super
    self.session_token = SecureRandom.alphanumeric(16)
    self.name = ""
    self.bio = ""
    self.background = ""
    self.language = "ja"
    self.email_verified = false
    self.followings_count = 0
    self.bookmarks_count = 0
  end

  def send_verification_email
    # TODO
  end

  def setup?
    name.present? && background.present?
  end

  def display_profile_image
    if profile_image.attached?
      profile_image
    else
      "default_profile_image.png"
    end
  end

  def page_editor?(page)
    page_users.find_by(page_id: page.id)
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
end
