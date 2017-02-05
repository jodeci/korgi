class Post < ApplicationRecord
  include FriendlyId
  friendly_id :slug, use: [:slugged, :finders]
end
