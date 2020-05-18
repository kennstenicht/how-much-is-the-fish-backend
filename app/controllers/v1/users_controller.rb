# frozen_string_literal: true

module V1
  # Controller for users
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show update destroy]

    # GET /users
    def index
      authorize User

      parent = find_parent(%w[workspace])
      @users = parent ? parent.users : policy_scope(User)

      allowed = %i[firstname lastname email]

      jsonapi_filter(policy_scope(@users), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /users/1
    def show
      authorize @user

      render jsonapi: @user
    end

    # POST /users
    def create
      @user = User.new(jsonapi_deserialize(params))

      authorize @user

      if @user.save
        render jsonapi: @user, status: :created, location: @user
      else
        render jsonapi: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      authorize @user

      if @user.update(jsonapi_deserialize(params))
        render jsonapi: @user
      else
        render jsonapi: @user.errors, status: :unprocessable_entity
      end
    end

    # DELETE /users/1
    def destroy
      authorize @user

      @user.destroy
    end

    private

    def set_user
      id = params[:user_id] || params[:id]

      @user = User.find(id)
    end
  end
end
