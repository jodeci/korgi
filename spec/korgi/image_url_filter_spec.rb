# frozen_string_literal: true
require "rails_helper"
require "korgi/image_url_filter"

describe Korgi::ImageUrlFilter do
  before { FactoryGirl.create(:image) }
  subject do
    filter = Korgi::ImageUrlFilter.new(doc)
    filter.call.to_s
  end

  context "when there is a matching image" do
    let(:doc) { "%image.1.thumb%" }
    it "will replace the string with the path" do
      expect(subject).to eq "#{store_dir_prefix}/image/file/1/thumb_test.jpg"
    end
  end

  context "when there is no matching image" do
    let(:doc) { "%book.3%" }
    it "will not replace the string" do
      expect(subject).to eq "%book.3%"
    end
  end
end
