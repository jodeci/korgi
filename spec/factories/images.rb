# frozen_string_literal: true
include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :image do
    id { 1 }
    file { fixture_file_upload("spec/support/test.jpg", "image/jpg") }
    after(:create) do |image, proxy|
      proxy.file.close
    end
  end
end
