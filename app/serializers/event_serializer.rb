# frozen_string_literal: true

# Serializer for events
class EventSerializer < ApplicationSerializer
  attributes :name, :date, :guests

  has_many :artists, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_event_artists_url(object.id)
    end
  }

  has_many :workspaces, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_event_workspaces_url(object.id)
    end
  }
end
