# frozen_string_literal: true
require "rails/all"
require "spec_helper"
require "dummy/config/environment"
require "rspec/rails"
require_relative "support/uploader_spec_helper"

RSpec.configure do |config|
  config.include UploaderSpecHelper
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

FactoryGirl.definition_file_paths = [File.expand_path("../factories", __FILE__)]
FactoryGirl.find_definitions
