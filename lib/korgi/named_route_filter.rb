# frozen_string_literal: true
require "html/pipeline"
module Korgi
  class NamedRouteFilter < ::HTML::Pipeline::Filter
    attr_reader :target, :id

    include ActionView::Helpers
    include Rails.application.routes.url_helpers

    def initialize(doc, context = nil, result = nil)
      super doc, context, result
      @target, @id = nil
    end

    def call
      doc.to_s.gsub(pattern) { replace(Regexp.last_match) }
    end

    private

    def pattern
      %r{\$#([\w]+).([\d]+)\$}
    end

    def replace(matches)
      origin, @target, @id = matches.to_a
      valid_target? ? resource_url : origin
    rescue ActionController::UrlGenerationError
      origin
    end

    def resource_url
      url_for(controller: controller, action: "show", id: find_object, only_path: true)
    end

    def find_object
      primary_key == :id ? id : klass.find(id).send(primary_key)
    rescue ActiveRecord::RecordNotFound
      id
    end

    def valid_target?
      Korgi.config.named_routes.key?(target.to_sym)
    end

    def configured_value(key)
      Korgi.config.named_routes[target.to_sym][key]
    end

    def controller
      configured_value(:controller)
    end

    def klass
      configured_value(:model)
    end

    def primary_key
      configured_value(:primary_key) || :id
    end
  end
end
