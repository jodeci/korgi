# frozen_string_literal: true
require "rails_helper"
require "korgi/file_upload_filter"

describe Korgi::FileUploadFilter do
  before { FactoryGirl.create(:image) }
  subject do
    filter = Korgi::FileUploadFilter.new(doc)
    filter.call.to_s
  end

  context "when there is a matching image" do
    context "$+image.1.large$" do
      let(:doc) { "$+image.1.large$" }
      it "will replace the string with the path of the specified version" do
        expect(subject).to eq "/uploads/image/file/1/large_test.jpg"
      end
    end

    context "$+image.1.invalid$" do
      let(:doc) { "$+image.1.invalid$" }
      it "will replace the string with the path of the default version" do
        expect(subject).to eq "/uploads/image/file/1/thumb_test.jpg"
      end
    end

    context "$+image.1$" do
      let(:doc) { "$+image.1$" }
      it "will replace the string with the path of the default version" do
        expect(subject).to eq "/uploads/image/file/1/thumb_test.jpg"
      end
    end
  end

  context "when there is no matching image" do
    let(:doc) { "$+book.3$" }
    it "will not replace the string" do
      expect(subject).to eq "$+book.3$"
    end
  end
end
