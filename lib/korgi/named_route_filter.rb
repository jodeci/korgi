# frozen_string_literal: true
require "html/pipeline"
module Korgi
  class NamedRouteFilter < ::HTML::Pipeline::Filter
    include ActionView::Helpers
    include ActionDispatch::Routing
    include Rails.application.routes.url_helpers

    def initialize(doc, context = nil, result = nil)
      super doc, context, result
    end

    def call
      str = doc.to_s.gsub(pattern) { replace(Regexp.last_match) }
      Nokogiri::HTML::DocumentFragment.parse(str)
    end

    private

    def replace(matches)
      result, model, id = matches.to_a
      url_for(controller: Korgi.config.named_routes[model.to_sym], action: "show", id: id, only_path: true)
    rescue ActionController::UrlGenerationError
      result
    end

    def pattern
      %r{\$#([\w]+).([\d]+)\$}
    end
  end
end
