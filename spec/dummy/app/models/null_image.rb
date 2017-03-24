# frozen_string_literal: true
class NullImage
  attr_reader :file

  class << self
    def file
      NullImageFile
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
