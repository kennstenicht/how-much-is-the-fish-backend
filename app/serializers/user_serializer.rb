# frozen_string_literal: true

# Serializer for venues
class UserSerializer < ApplicationSerializer
  attributes :firstname, :lastname, :fullname, :email

  has_many :workspaces, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_user_workspaces_url(object.id)
    end
  }

  link :self, :url
end
