# frozen_string_literal: true

# Base application controller
class ApplicationController < ActionController::API
  include Knock::Authenticable
  include Pundit

  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    head :forbidden
  end
end
