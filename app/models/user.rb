class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password_digest, presence: true

  def initialize(attributes = {})
    super
    self.session_token = SecureRandom.alphanumeric(16)
    self.name = "user#{id}"
    self.profile_image = ""
    self.bio = ""
    self.language = "ja"
    self.email_verified = false
    self.followings_count = 0
    self.bookmarks_count = 0
  end

  def send_verification_email
    # TODO
  end
end
