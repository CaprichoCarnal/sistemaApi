class Api::V1::ReturnsController < ApplicationController
    before_action :set_return, only: [:show, :update, :destroy]

    # GET /returns
    def index
      @returns = Return.includes(:invoice, return_items: :sale_item).all
      render json: @returns.to_json(include: { invoice: {}, return_items: { include: :sale_item } })
    end
  
    # GET /returns/:id
    def show
      render json: @return
    end
  
    # POST /returns
    def create
      @return = Return.new(return_params)
  
      if @return.save
        render json: @return, status: :created
      else
        render json: @return.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /returns/:id
    def update
      if @return.update(return_params)
        render json: @return
      else
        render json: @return.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /returns/:id
    def destroy
      @return.destroy
      head :no_content
    end
  
    private
  
    def set_return
      @return = Return.find(params[:id])
    end
  
    def return_params
      params.require(:return).permit(:invoice_id, :reason, return_items_attributes: [:sale_item_id, :quantity_returned, :reason])
    end
end
