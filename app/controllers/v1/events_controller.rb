# frozen_string_literal: true

module V1
  # Controller for events
  class EventsController < ApplicationController
    before_action :set_event, only: %i[show update destroy]
    before_action :deserialize_params, only: %i[create update]

    # GET /events
    def index
      authorize Event

      parent = find_parent(%w[artist workspace])
      @events = parent ? parent.events : Event

      allowed = %i[date name]

      jsonapi_filter(policy_scope(@events), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /events/1
    def show
      authorize @event

      render jsonapi: @event
    end

    # POST /events
    def create
      @event = Event.new(@params_deserialized)

      authorize @event

      if @event.save
        render jsonapi: @event, status: :created, location: v1_event_url(@event)
      else
        render jsonapi: @event.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /events/1
    def update
      authorize @event

      if @event.update(@params_deserialized)
        render jsonapi: @event
      else
        render jsonapi: @event.errors, status: :unprocessable_entity
      end
    end

    # DELETE /events/1
    def destroy
      authorize @event

      @event.destroy
    end

    private

    def set_event
      id = params[:event_id] || params[:id]

      @event = Event.find(id)
    end

    def deserialize_params
      params_only = %i[artists date guests name workspaces]

      @params_deserialized = jsonapi_deserialize(params, only: params_only)
    end
  end
end
