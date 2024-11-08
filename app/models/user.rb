class User < ApplicationRecord
  has_secure_password
  has_one_attached :profile_image

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
end
