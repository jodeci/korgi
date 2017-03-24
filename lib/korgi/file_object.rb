# frozen_string_literal: true
module Korgi
  class FileObject
    attr_reader :klass, :id, :nil_object

    def initialize(klass, id, nil_object)
      @klass = klass
      @id = id
      @nil_object = nil_object
    end

    def fetch
      klass.find(id)
    rescue ActiveRecord::RecordNotFound, NameError
      nil_object || Korgi::NullFileObject
    end
  end

  class NullFileObject
    class << self
      def url(_version)
        nil
      end
    end
  end
end
