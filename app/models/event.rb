# frozen_string_literal: true

# Event model
class Event < ApplicationRecord
  # Relationship
  has_and_belongs_to_many :artists
  has_and_belongs_to_many :workspaces
  belongs_to :venue, optional: true

  def url
    Rails.application.routes.url_helpers.v1_event_url(id)
  end
end
