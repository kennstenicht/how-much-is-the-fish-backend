# frozen_string_literal: true

# Serializer for venues
class VenueSerializer < ApplicationSerializer
  attributes :name

  belongs_to :events, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_venue_events_url(object.id)
    end
  }

  has_many :workspaces, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_venue_workspaces_url(object.id)
    end
  }

  link :self, :url
end
