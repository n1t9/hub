class PagePost < ApplicationRecord
  has_one_attached :cover_image
  belongs_to :page

  def display_cover_image
    if cover_image.attached?
      cover_image.representation(resize_to_fill: [ 1200, 628 ])
    else
      "default_post_cover_image.png"
    end
  end
end
