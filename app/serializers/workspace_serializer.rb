# frozen_string_literal: true

# Serializer for workspaces
class WorkspaceSerializer < ApplicationSerializer
  attributes :name

  belongs_to :events, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_workspace_events_url(object.id)
    end
  }

  has_many :venues, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_workspace_venues_url(object.id)
    end
  }

  has_many :users, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_workspace_users_url(object.id)
    end
  }

  has_many :artists, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_workspace_artists_url(object.id)
    end
  }

  link :self, :url
end
