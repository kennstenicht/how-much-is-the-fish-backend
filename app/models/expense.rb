# frozen_string_literal: true

# Expense model
class Expense < ApplicationRecord
  def url
    Rails.application.routes.url_helpers.v1_expense_url(id)
  end
end
