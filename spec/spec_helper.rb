# frozen_string_literal: true
require "simplecov"
SimpleCov.start do
  add_filter "spec"
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "rubygems"
require "bundler/setup"
require "korgi"

RSpec.configure do |config|
  config.after(:all) do
    FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads"])
  end
end
