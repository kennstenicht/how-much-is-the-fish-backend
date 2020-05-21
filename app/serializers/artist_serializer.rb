# frozen_string_literal: true

# Serializer for artists
class ArtistSerializer < ApplicationSerializer
  attributes :name

  has_many :events, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_artist_events_url(object.id)
    end
  }
end
