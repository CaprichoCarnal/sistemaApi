class Api::V1::HistoricQuarteringsController < ApplicationController
    before_action :set_historic_quartering, only: [:show, :update, :destroy]

    def index
        @historic_quarterings = HistoricQuartering.all
        render json: @historic_quarterings
    end

    def create
        @historic_quartering = HistoricQuartering.new(historic_quartering_params)
        if @historic_quartering.save
            render json: @historic_quartering, status: :created, location: @historic_quartering
        else
            render json: @historic_quartering.errors, status: :unprocessable_entity
        end
    end

    def update
        if @historic_quartering.update(historic_quartering_params)
            render json: @historic_quartering
        else
            render json: @historic_quartering.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @historic_quartering.destroy
    end

    private

    def set_historic_quartering
        @historic_quartering = HistoricQuartering.find(params[:id])
    end

    def historic_quartering_params
        params.permit(:date, :id_channel, :piece_name, :lot, :operator_signature)
    end
end
