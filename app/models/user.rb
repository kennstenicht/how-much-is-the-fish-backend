# frozen_string_literal: true

# User model
class User < ApplicationRecord
  has_secure_password

  # Validations
  validates :firstname,
            :lastname, presence: true

  validates :email, presence: true,
                    uniqueness: true

  has_and_belongs_to_many :workspaces

  def fullname
    "#{firstname} #{lastname}"
  end

  def url
    Rails.application.routes.url_helpers.v1_user_url(id)
  end

  def workspace?(workspaces_to_check)
    workspaces.any? { |r| workspaces_to_check.include?(r) }
  end
end
