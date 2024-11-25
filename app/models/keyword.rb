class Keyword < ApplicationRecord
  belongs_to :category
  has_many :page_keywords
  has_many :pages, through: :page_keywords
end
