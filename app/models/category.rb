class Category < ApplicationRecord
  has_many :pages
  has_and_belongs_to_many :official_posts
end
