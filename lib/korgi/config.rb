# frozen_string_literal: true
require "active_support/configurable"
module Korgi
  include ActiveSupport::Configurable
  config.instance_eval do
    self.named_routes = {} # { post: "dashboard/posts" }
    self.file_uploads = {} # { image: [Image, :file, :thumb] }
  end
end
