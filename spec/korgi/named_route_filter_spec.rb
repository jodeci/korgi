# frozen_string_literal: true
require "rails_helper"
require "korgi/named_route_filter"

describe Korgi::NamedRouteFilter do
  subject do
    filter = Korgi::NamedRouteFilter.new(doc)
    filter.call.to_s
  end

  context "when there is a matching route" do
    let(:doc) { "$post.1$" }
    it "will replace the string with the path" do
      expect(subject).to eq "/posts/1"
    end
  end

  context "when there is no matching route" do
    let(:doc) { "$book.3$" }
    it "will not replace the string" do
      expect(subject).to eq "$book.3$"
    end
  end
end
