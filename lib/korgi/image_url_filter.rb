# frozen_string_literal: true
require "html/pipeline"
#require "carrierwave"
#require "mini_magick"
module Korgi
  class ImageUrlFilter < ::HTML::Pipeline::Filter
    #include ActionView::Helpers
    #include ActionDispatch::Routing
    #include Rails.application.routes.url_helpers

    def initialize(doc, context = nil, result = nil)
      super doc, context, result
    end

    def call
      str = doc.to_s.gsub(path_pattern) { replace_path(Regexp.last_match) }
      Nokogiri::HTML::DocumentFragment.parse(str)
    end

    private

    def replace_path(matches)
      result, model, id, version = matches.to_a
      # TODO: lookup matching model and mounter from initializer
      Image.find(id).file.url(version)
    rescue ActiveRecord::RecordNotFound
      result
    end

    def path_pattern
      %r{%([\w]+)\.([\d]+)(?:\.([\w]+))?%}
    end
  end
end
