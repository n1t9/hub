class PageManager < ApplicationRecord
  belongs_to :page
  belongs_to :user

  enum role: { admin: 1, member: 2 }
end
