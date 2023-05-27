class Api::V1::InventoriesController < ApplicationController
    before_action :load_inventories, except: [:create]
    before_action :load_inventory, only: [:show, :update, :destroy]
  
    def index
      render json: @inventories
    end
  
    def show
      render json: @inventory
    end
  
    def create
      inventory = Inventory.new(inventory_params)
      if inventory.save
        render json: inventory, status: :created
      else
        render json: { errors: inventory.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      if @inventory.update(inventory_params)
        render json: @inventory
      else
        render json: { errors: @inventory.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @inventory.destroy
      head :no_content
    end
  
    private
  
    def load_inventories
      @inventories = Inventory.all
    end
  
    def load_inventory
      @inventory = Inventory.find(params[:id])
    end
  
    def inventory_params
      params.require(:inventory).permit(:item_id, :item_type, :lot, :weight, :expiration_date)
    end
end
