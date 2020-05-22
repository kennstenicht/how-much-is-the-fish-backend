# frozen_string_literal: true

module V1
  # Controller for venues
  class WorkspacesController < ApplicationController
    before_action :set_workspace, only: %i[show update destroy]
    before_action :deserialize_params, only: %i[create update]

    # GET /workspaces
    def index
      authorize Workspace

      parent = find_parent(%w[artist event user venue])
      @workspaces = parent ? parent.workspaces : policy_scope(Workspace)

      allowed = %i[name]

      jsonapi_filter(policy_scope(@workspaces), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /workspaces/1
    def show
      authorize @workspace

      render jsonapi: @workspace
    end

    # POST /workspaces
    def create
      @workspace = Workspace.new(@params_deserialized)

      authorize @workspace

      if @workspace.save
        render jsonapi: @workspace, status: :created, location: @workspace
      else
        render jsonapi_errors: @workspace.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /workspaces/1
    def update
      authorize @workspace

      if @workspace.update(@params_deserialized)
        render jsonapi: @workspace
      else
        render jsonapi_errors: @workspace.errors, status: :unprocessable_entity
      end
    end

    # DELETE /workspaces/1
    def destroy
      authorize @workspace

      @workspace.destroy
    end

    private

    def set_workspace
      id = params[:workspace_id] || params[:id]

      @workspace = Workspace.find(id)
    end

    def deserialize_params
      params_only = %i[artists events name users venues]

      @params_deserialized = jsonapi_deserialize(params, only: params_only)
    end
  end
end
