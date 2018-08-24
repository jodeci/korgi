# frozen_string_literal: true
require "rails_helper"
require "korgi/named_route_filter"

describe Korgi::NamedRouteFilter do
  before { FactoryBot.create(:post) }
  subject do
    filter = Korgi::NamedRouteFilter.new(doc)
    filter.call.to_s
  end

  context "when there is a matching route" do
    context "when the user has specified a slug instead of id" do
      let(:doc) { "$#post.1$" }
      it "will replace the string with the slugged path" do
        expect(subject).to eq "/posts/slug-url"
      end

      context "when there is no matching resourse" do
        let(:doc) { "$#post.99$" }
        it "will replace the string with the numeric path" do
          expect(subject).to eq "/posts/99"
        end
      end
    end

    context "when using id as default" do
      let(:doc) { "$#apost.3$" }
      it "will replace the string with the numeric path" do
        expect(subject).to eq "/admin/posts/3"
      end
    end
  end

  context "when there is no matching route" do
    context "when the resource is not configured" do
      let(:doc) { "$#book.3$" }
      it "will not replace the string" do
        expect(subject).to eq "$#book.3$"
      end
    end

    context "when a configured resource does not exist" do
      let(:doc) { "$#movie.1$" }
      it "will not replace the string" do
        expect(subject).to eq "$#movie.1$"
      end
    end
  end
end
