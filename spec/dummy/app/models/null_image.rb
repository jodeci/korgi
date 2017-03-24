# frozen_string_literal: true
class NullImage
  attr_reader :large_url, :medium_url, :thumb_url, :file

  class << self
    def file
      NullImageFile
    end

    def large_url
      asset_path("large")
    end

    def medium_url
      asset_path("medium")
    end

    def thumb_url
      asset_path("thumb")
    end

    def asset_path(size)
      ActionController::Base.helpers.asset_path("no_image_#{size}.png")
    end
  end
end

class NullImageFile
  class << self
    def url(size = "medium")
      NullImage.asset_path(size)
    end
  end
end
