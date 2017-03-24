# frozen_string_literal: true
require "html/pipeline"
require "korgi/file_object"
module Korgi
  class FileUploadFilter < ::HTML::Pipeline::Filter
    attr_reader :target, :id, :version

    def initialize(doc, context = nil, result = nil)
      super doc, context, result
      @target, @id, @version = nil
    end

    def call
      doc.to_s.gsub(pattern) do
        origin, @target, @id, @version = Regexp.last_match.to_a
        valid_target? ? file_url : origin
      end
    end

    private

    def pattern
      %r{\$\+([\w]+).([\d]+)(?:.([\w]+))?\$}
    end

    def file_url
      Korgi::FileObject.new(klass, id, nil_object).fetch.send(mount).url(file_version)
    end

    def valid_target?
      Korgi.config.file_uploads.key?(target.to_sym)
    end

    def configured_value(key)
      Korgi.config.file_uploads[target.to_sym][key]
    end

    def klass
      configured_value(:model)
    end

    def mount
      configured_value(:mount)
    end

    def nil_object
      configured_value(:nil_object)
    end

    def default_version
      configured_value(:default_version)
    end

    def file_version
      if version
        valid_file_version? ? version : default_version
      else
        default_version
      end
    end

    def valid_file_version?
      file_versions.include?(version.to_sym)
    end

    def file_versions
      klass.uploaders[mount].versions.keys
    end
  end
end
