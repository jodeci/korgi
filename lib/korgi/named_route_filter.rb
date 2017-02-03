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
      str = doc.to_s.gsub(path_pattern) { replace_path(Regexp.last_match) }
      Nokogiri::HTML::DocumentFragment.parse(str)
    end

    private

    def replace_path(matches)
      result, model, id = matches.to_a
      url_for(controller: controller_name(model), action: "show", id: id, only_path: true)
    rescue ActionController::UrlGenerationError
      result
    end

    def controller_name(model)
      # TODO: lookup matching controller from initializer
      model.pluralize
    end

    def path_pattern
      %r{\$([\w]+)\.([\d]+)\$}
    end
  end
end
