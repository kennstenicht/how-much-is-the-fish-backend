# frozen_string_literal: true

module V1
  # Controller for venues
  class VenuesController < ApplicationController
    before_action :set_venue, only: %i[show update destroy]
    before_action :deserialize_params, only: %i[create update]

    # GET /venues
    def index
      authorize Venue

      parent = find_parent(%w[workspace])
      @venues = parent ? parent.venues : policy_scope(Venue)

      allowed = %i[name]

      jsonapi_filter(policy_scope(@venues), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /venues/1
    def show
      authorize @venue

      render jsonapi: @venue
    end

    # POST /venues
    def create
      @venue = Venue.new(@params_deserialized)

      authorize @venue

      if @venue.save
        render jsonapi: @venue, status: :created, location: @venue
      else
        render jsonapi_errors: @venue.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /venues/1
    def update
      authorize @venue

      if @venue.update(@params_deserialized)
        render jsonapi: @venue
      else
        render jsonapi_errors: @venue.errors, status: :unprocessable_entity
      end
    end

    # DELETE /venues/1
    def destroy
      authorize @venue

      @venue.destroy
    end

    private

    def set_venue
      id = params[:venue_id] || params[:id]

      @venue = Venue.find(id)
    end

    def deserialize_params
      params_only = %i[events name workspaces]

      @params_deserialized = jsonapi_deserialize(params, only: params_only)
    end
  end
end
