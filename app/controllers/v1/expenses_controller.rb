# frozen_string_literal: true

module V1
  # Controller for expases
  class ExpensesController < ApplicationController
    before_action :set_expense, only: %i[show update destroy]

    # GET /expenses
    def index
      @expenses = Expense.all

      render jsonapi: @expenses
    end

    # GET /expenses/1
    def show
      render jsonapi: @expense
    end

    # POST /expenses
    def create
      @expense = Expense.new(expense_params)

      if @expense.save
        render jsonapi: @expense, status: :created, location: @expense
      else
        render jsonapi_errors: @expense.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /expenses/1
    def update
      if @expense.update(expense_params)
        render jsonapi: @expense
      else
        render jsonapi_errors: @expense.errors, status: :unprocessable_entity
      end
    end

    # DELETE /expenses/1
    def destroy
      @expense.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def expense_params
      params.require(:expense).permit(:name, :quantity, :price, :note, :expense_category)
    end
  end
end
