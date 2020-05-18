# frozen_string_literal: true

module V1
  # Controller for artists
  class ArtistsController < ApplicationController
    before_action :set_artist, only: %i[show update destroy events]

    # GET /artists
    def index
      authorize Artist

      parent = find_parent(%w[event workspace])
      @artists = parent ? parent.artists : Artist

      allowed = %i[name]

      jsonapi_filter(policy_scope(@artists), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /artists/1
    def show
      authorize @artist

      render jsonapi: @artist
    end

    # POST /artists
    def create
      @artist = Artist.new(jsonapi_deserialize(params))

      authorize @artist

      if @artist.save
        render jsonapi: @artist, status: :created, location: @artist
      else
        render jsonapi: @artist.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /artists/1
    def update
      authorize @artist

      if @artist.update(jsonapi_deserialize(params))
        render jsonapi: @artist
      else
        render jsonapi: @artist.errors, status: :unprocessable_entity
      end
    end

    # DELETE /artists/1
    def destroy
      authorize @artist

      @artist.destroy
    end

    private

    def set_artist
      id = params[:artist_id] || params[:id]

      @artist = Artist.find(id)
    end
  end
end
