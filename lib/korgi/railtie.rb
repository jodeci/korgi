# frozen_string_literal: true
require "rails/railtie"
module Korgi
  class Railtie < ::Rails::Railtie
    config.after_initialize do
      require "korgi/named_route_filter"
      require "korgi/file_upload_filter"
    end
  end
end
