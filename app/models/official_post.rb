class OfficialPost < ApplicationRecord
  has_one_attached :cover_image

  def display_cover_image
    if cover_image.attached?
      cover_image
    else
      "default_post_cover_image.webp"
    end
  end
end
