module SlideshowsHelper
  def thumbnail_tag(slide)
    image_tag "photos/#{slide.photo.thumbnail}", style:"vertical-align:middle;" if slide
  end
end
