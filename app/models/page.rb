# genre_id
#   1: 民間
#   2: 行政

class Page < ApplicationRecord
  has_many :page_users
  has_many :users, through: :page_users
  has_many :page_keywords
  has_many :keywords, through: :page_keywords
end
