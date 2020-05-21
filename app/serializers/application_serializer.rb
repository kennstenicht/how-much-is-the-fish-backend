# frozen_string_literal: true

# Base application Serializer
class ApplicationSerializer
  include FastJsonapi::ObjectSerializer
  include UrlHelpers

  # Key transform
  set_key_transform :dash

  # Global meta fields
  attributes :created_at, :updated_at
end
