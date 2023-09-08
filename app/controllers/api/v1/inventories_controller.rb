class Api::V1::InventoriesController < ApplicationController
  before_action :set_inventory, only: [:show, :update, :destroy]

  def index
    @inventories = Inventory.includes(:item).where('weight > ?',0).order(created_at: :desc).all
    render json: @inventories, include: [:item]
  end

  
  def show
    render json: @inventory
  end

  def create
    inventories_data = params[:inventories]  # Recibe una matriz de inventarios
    
    @inventories = []

    inventories_data.each do |inventory_data|
      inventory = Inventory.new(inventory_data.permit(:item_id, :item_type, :category, :lot, :weight, :expiration_date, :name))

      if inventory.save
        @inventories << inventory
      end
    end

    if @inventories.present?
      render json: @inventories, status: :created
    else
      render json: { error: "No se pudieron crear los inventarios" }, status: :unprocessable_entity
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
    params.require(:inventory).permit(:item_id, :item_type, :category, :lot, :weight, :expiration_date, :name).tap do |whitelisted|
      whitelisted[:item_type] = nil if whitelisted[:item_type].blank?
    end
  end
  
  
end
