# frozen_string_literal: true
require "rails/all"
require "html/pipeline"
module Korgi
  class NamedRouteFilter < ::HTML::Pipeline::Filter
    include ActionView::Helpers
    include Rails.application.routes.url_helpers

    def initialize(doc, context = nil, result = nil)
      super doc, context, result
      @id, @klass = nil
    end

    def call
      doc.to_s.gsub(pattern) { replace(Regexp.last_match) }
    end

    private

    def replace(matches)
      result, target, id = matches.to_a
      controller, @klass, @id = Korgi.config.named_routes[target.to_sym]
      @id ||= :id
      url_for(controller: controller, action: "show", id: find_object(id), only_path: true)
    rescue ActionController::UrlGenerationError
      result
    end

    def find_object(id)
      @id == :id ? id : @klass.find(id).send(@id)
    rescue ActiveRecord::RecordNotFound
      id
    end

    def pattern
      %r{\$#([\w]+).([\d]+)\$}
    end
  end
end
