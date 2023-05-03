class Api::V1::ProcessHistoriesController < ApplicationController
    before_action :set_process_history, only: [:show, :update, :destroy]

    def index
        @process_histories = ProcessHistory.select(:id, :date, :material_name, :material_lot_number, :product_name, :product_lot_number)
        render json: @process_histories
    end

    def show
        render json: @process_history
    end

    def create
        @process_history = ProcessHistory.new(process_history_params)

        if @process_history.save
            render json: @process_history, status: :created
        else
            render json: @process_history.errors, status: :unprocessable_entity
        end
    end

    def update
        if @process_history.update(process_history_params)
            render json: @process_history
        else
            render json: @process_history.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @process_history.destroy
    end

    private

    def set_process_history
        @process_history = ProcessHistory.find(params[:id])
    end

    def process_history_params
        params.permit(:date, :material_name, :material_lot_number, :product_name, :product_lot_number)
    end
end
