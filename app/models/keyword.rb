class Keyword < ApplicationRecord
  belongs_to :category
  has_many :page_keywords
end
