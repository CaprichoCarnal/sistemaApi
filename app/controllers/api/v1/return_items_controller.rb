class Api::V1::ReturnItemsController < ApplicationController
    before_action :set_return_item, only: [:show,  :update, :destroy]

    # GET /return_items
    def index
      @return_items = ReturnItem.all
      render json: @return_items
    end
  
    # GET /return_items/:id
    def show
      render json: @return_item
    end
  
    # POST /return_items
    def create
      @return_item = ReturnItem.new(return_item_params)
  
      if @return_item.save
        render json: @return_item, status: :created
      else
        render json: @return_item.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /return_items/:id
    def update
      if @return_item.update(return_item_params)
        render json: @return_item
      else
        render json: @return_item.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /return_items/:id
    def destroy
      @return_item.destroy
      head :no_content
    end
  
    private
  
    def set_return_item
      @return_item = ReturnItem.find(params[:id])
    end
  
    def return_item_params
      params.require(:return_item).permit(:return_id, :sale_item_id, :quantity_returned, :reason)
    end
end
