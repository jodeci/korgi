# frozen_string_literal: true
require "html/pipeline"
module Korgi
  class ImageUrlFilter < ::HTML::Pipeline::Filter
    def initialize(doc, context = nil, result = nil)
      super doc, context, result
      @klass, @mount, @version = nil
    end

    def call
      str = doc.to_s.gsub(pattern) { replace(Regexp.last_match) }
      Nokogiri::HTML::DocumentFragment.parse(str)
    end

    private

    def replace(matches)
      result, model, id, version = matches.to_a
      @klass, @mount, @version = Korgi.config.images[model.to_sym]
      version ||= @version
      @klass.find(id).send(@mount).url(file_version(version))
    rescue ActiveRecord::RecordNotFound, NameError
      result
    end

    def file_version(version)
      if valid_file_version?(version)
        version
      else
        @version
      end
    end

    def valid_file_version?(version)
      file_versions.include?(version.to_sym)
    end

    def file_versions
      @klass.uploaders[@mount].versions.keys
    end

    def pattern
      %r{\$\+([\w]+).([\d]+)(?:.([\w]+))?\$}
    end
  end
end
