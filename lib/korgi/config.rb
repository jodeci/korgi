# frozen_string_literal: true
require "active_support/configurable"
module Korgi
  include ActiveSupport::Configurable
  config.instance_eval do
    self.named_routes = {} # { post: { controller: :posts, model: Post, primary_key: :slug } }
    self.file_uploads = {} # { image: { model: Image, mount: :file, default_version: :thumb, nil_object: NullImage } }
  end
end
