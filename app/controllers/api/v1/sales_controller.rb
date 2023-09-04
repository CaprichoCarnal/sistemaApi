class Api::V1::SalesController < ApplicationController
    before_action :set_sale, only: [:show, :update, :destroy]

    def index
      @sales = Sale.includes(customer: [:commercial_agent], sale_items: { inventory: [:item] }).order(created_at: :desc).all
      render json: @sales, include: { customer: { include: :commercial_agent }, sale_items: { include: { inventory: { include: :item } } }, commercial_agent: {} }
    end
    
  def show
    render json: @sale
  end

  def create
    @sale = Sale.new(sale_params)
    if @sale.save
      render json: @sale, status: :created
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  def update
    if @sale.update(sale_params)
      render json: @sale
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @sale.destroy
    head :no_content
  end

  private

  def set_sale
    @sale = Sale.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:customer_id, :date, :vat,:total, :commercial_agent_id ,sale_items_attributes: [:inventory_id, :quantity, :price,:product_sold,:weight])
  end
end
