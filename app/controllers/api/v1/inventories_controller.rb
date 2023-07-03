class Api::V1::InventoriesController < ApplicationController
  before_action :set_inventory, only: [:show, :update, :destroy]

  def index
    @inventories = Inventory.includes(:item).order(created_at: :desc).all
    render json: @inventories, include: [:item]
  end

  
  def show
    render json: @inventory
  end

  def create
    @inventory = Inventory.new(inventory_params)

    if @inventory.save
      render json: @inventory, status: :created
    else
      render json: @inventory.errors, status: :unprocessable_entity
    end
  end

  def update
    if @inventory.update(inventory_params)
      render json: @inventory
    else
      render json: @inventory.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @inventory.destroy
    head :no_content
  end

  private

  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

  def inventory_params
    params.require(:inventory).permit(:item_id, :item_type, :category, :lot, :weight, :expiration_date)
  end
end
