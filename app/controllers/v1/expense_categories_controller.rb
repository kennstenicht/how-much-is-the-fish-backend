# frozen_string_literal: true

module V1
  # Controller for expase categories
  class ExpenseCategoriesController < ApplicationController
    before_action :set_expense_category, only: %i[show update destroy]

    # GET /expense_categories
    def index
      @expense_categories = ExpenseCategory.all

      authorize @artists
      
      render jsonapi: @expense_categories
    end

    # GET /expense_categories/1
    def show
      render jsonapi: @expense_category
    end

    # POST /expense_categories
    def create
      @expense_category = ExpenseCategory.new(expense_category_params)

      if @expense_category.save
        render jsonapi: @expense_category, status: :created, location: @expense_category
      else
        render jsonapi: @expense_category.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /expense_categories/1
    def update
      if @expense_category.update(expense_category_params)
        render jsonapi: @expense_category
      else
        render jsonapi: @expense_category.errors, status: :unprocessable_entity
      end
    end

    # DELETE /expense_categories/1
    def destroy
      @expense_category.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_expense_category
      @expense_category = ExpenseCategory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def expense_category_params
      params.require(:expense_category).permit(:name)
    end
  end
end
