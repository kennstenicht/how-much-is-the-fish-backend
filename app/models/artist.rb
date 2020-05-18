# frozen_string_literal: true

# Artist model
class Artist < ApplicationRecord
  # Relationship
  has_and_belongs_to_many :events
  has_and_belongs_to_many :workspaces

  def url
    Rails.application.routes.url_helpers.v1_artist_url(id)
  end
end
