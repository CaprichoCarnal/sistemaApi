class Api::V1::HistoricalElaborationsController < ApplicationController
    before_action :set_historical_elaboration, only: [:show, :update, :destroy]

    # GET /api/v1/historical_elaborations
    def index
        @historical_elaborations = HistoricalElaboration.all
        render json: @historical_elaborations
    end

    # GET /api/v1/historical_elaborations/1
    def show
        render json: @historical_elaboration
    end

    # POST /api/v1/historical_elaborations
    def create
        @historical_elaboration = HistoricalElaboration.new(historical_elaboration_params)

        if @historical_elaboration.save
            render json: @historical_elaboration, status: :created
        else
            render json: @historical_elaboration.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /api/v1/historical_elaborations/1
    def update
        if @historical_elaboration.update(historical_elaboration_params)
            render json: @historical_elaboration
        else
            render json: @historical_elaboration.errors, status: :unprocessable_entity
        end
    end

    # DELETE /api/v1/historical_elaborations/1
    def destroy
        @historical_elaboration.destroy
    end

    private

    def set_historical_elaboration
        @historical_elaboration = HistoricalElaboration.find(params[:id])
    end

    def historical_elaboration_params
        params.permit(:date, :product_name, :ingredients, :lot_number, :final_lot_number, :final_weight)
    end
end
