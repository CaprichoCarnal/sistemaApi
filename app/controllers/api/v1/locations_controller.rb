class Api::V1::LocationsController < ApplicationController
    before_action :set_location, only: [:show, :update, :destroy]

    # GET /api/v1/locations
    def index
      @location = Location.select(:id, :postal_code, :city, :province, :country)
        render json: @location
        #poblaciones = Location.select(:city).distinct.order(:city).pluck(:city)
        #provincias = Location.select(:province).distinct.order(:province).pluck(:province)
        #codigos_postales = Location.select(:postal_code).distinct.order(:postal_code).pluck(:postal_code)
        #country = Location.select(:country).distinct.order(:country).pluck(:country)

        #render json: { Poblaciones: poblaciones, Provincias: provincias, "Codigos-postales": codigos_postales, Country: country }
    end
  
  
    # GET /api/v1/locations/:id
    def show
      render json: @location
    end
  
    # POST /api/v1/locations
    def create
      @location = Location.new(location_params)
  
      if @location.save
        render json: @location, status: :created
      else
        render json: @location.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH /api/v1/locations/:id
    def update
      if @location.update(location_params)
        render json: @location
      else
        render json: @location.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/locations/:id
    def destroy
      @location.destroy
      head :no_content
    end
  
    private
    def set_location
      @location = Location.find(params[:id])
    end
  
    def location_params
      params.permit(:postal_code, :city, :province, :country)
    end
end
