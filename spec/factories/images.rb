# frozen_string_literal: true
include ActionDispatch::TestProcess
FactoryBot.define do
  factory :image do
    id { 1 }
    file { fixture_file_upload("spec/photo/test.jpg", "image/jpg") }
    after(:create) do |image, proxy|
      proxy.file.close
    end
  end
end
