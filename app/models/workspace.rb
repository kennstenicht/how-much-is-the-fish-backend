class Workspace < ApplicationRecord
  has_and_belongs_to_many :events
  has_and_belongs_to_many :venues
  has_and_belongs_to_many :artists
  has_and_belongs_to_many :users

  def url
    Rails.application.routes.url_helpers.v1_workspace_url(id)
  end
end
