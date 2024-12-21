class PagePost < ApplicationRecord
  has_one_attached :cover_image
  has_many :page_post_bookmarks, dependent: :destroy
  belongs_to :page

  validates :title, presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { maximum: 2000 }

  def display_cover_image
    if cover_image.attached?
      cover_image.representation(resize_to_fill: [ 1200, 628 ])
    else
      "default_post_cover_image.png"
    end
  end
end
