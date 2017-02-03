# frozen_string_literal: true
require "html/pipeline"
module Korgi
  class ImageUrlFilter < ::HTML::Pipeline::Filter
    def initialize(doc, context = nil, result = nil)
      super doc, context, result
    end

    def call
      str = doc.to_s.gsub(pattern) { replace(Regexp.last_match) }
      Nokogiri::HTML::DocumentFragment.parse(str)
    end

    private

    def replace(matches)
      result, model, id, version = matches.to_a
      object, upload_mount, default_version = Korgi.config.images[model.to_sym]
      version ||= default_version
      object.find(id).send(upload_mount).url(version)
    rescue ActiveRecord::RecordNotFound, NameError
      result
    end

    def pattern
      %r{%([\w]+)\.([\d]+)(?:\.([\w]+))?%}
    end
  end
end
