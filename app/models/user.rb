class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password_digest, presence: true
  validates :background, presence: true, length: { maximum: 100 }

  def initialize(attributes = {})
    super
    self.session_token = SecureRandom.alphanumeric(16)
    self.name = ""
    self.profile_image = ""
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
end
