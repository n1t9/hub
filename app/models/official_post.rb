class OfficialPost < ApplicationRecord
  has_one_attached :cover_image
  has_many :official_post_bookmarks, dependent: :destroy
  has_and_belongs_to_many :categories

  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 5000 }

  def display_cover_image
    if cover_image.attached?
      cover_image.representation(resize_to_fill: [ 1200, 628 ])
    else
      "default_post_cover_image.png"
    end
  end
end
