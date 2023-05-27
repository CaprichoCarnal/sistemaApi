class Api::V1::SaleItemsController < ApplicationController
    before_action :set_sale_item, only: [:show, :update, :destroy]

      def index
        @sale_items = SaleItem.all
        render json: @sale_items
      end

      def show
        render json: @sale_item
      end

      def create
        @sale_item = SaleItem.new(sale_item_params)
        
        if @sale_item.save
          render json: @sale_item, status: :created
        else
          render json: @sale_item.errors, status: :unprocessable_entity
        end
      end

      def update
        if @sale_item.update(sale_item_params)
          render json: @sale_item
        else
          render json: @sale_item.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @sale_item.destroy
        head :no_content
      end

      private

      def set_sale_item
        @sale_item = SaleItem.find(params[:id])
      end

      def sale_item_params
        params.require(:sale_item).permit(:sale_id, :inventory_id, :quantity, :price)
      end
end
