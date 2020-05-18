# frozen_string_literal: true

# Esxpense Category model
class ExpenseCategory < ApplicationRecord
  def url
    Rails.application.routes.url_helpers.v1_expense_category_url(id)
  end
end
