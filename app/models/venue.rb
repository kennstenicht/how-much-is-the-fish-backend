# frozen_string_literal: true

# Venue model
class Venue < ApplicationRecord
  has_and_belongs_to_many :workspaces
  has_and_belongs_to_many :events

  def url
    Rails.application.routes.url_helpers.v1_venue_url(id)
  end
end
