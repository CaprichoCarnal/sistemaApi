class Api::V1::SuppliesController < ApplicationController
    before_action :set_supply, only: [:show, :update, :destroy]

    def index
      @supplies = Supply.order(created_at: :desc).all
      render json: @supplies
    end
  
    def show
      render json: @supply
    end
  
    def create
      @supply = Supply.new(supply_params)
  
      if @supply.save
        render json: @supply, status: :created
      else
        render json: @supply.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @supply.update(supply_params)
        render json: @supply
      else
        render json: @supply.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @supply.destroy
      head :no_content
    end
  
    private
  
    def set_supply
      @supply = Supply.find(params[:id])
    end
  
    def supply_params
      params.permit(:supplier_id, :lot, :name, :quantity, :weight)
    end
end
