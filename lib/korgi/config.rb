# frozen_string_literal: true
require "active_support/configurable"
module Korgi
  include ActiveSupport::Configurable
  config.instance_eval do
    self.routes = {} # { post: "dashboard/posts" }
    self.images = {} # { image: [Image, :file, :thumb] }
  end
end
