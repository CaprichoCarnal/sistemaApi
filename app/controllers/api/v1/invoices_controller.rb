class Api::V1::InvoicesController < ApplicationController
    before_action :set_invoice, only: [:show, :update, :destroy]

   
    def index
      @latest_invoice = Invoice.joins(sale: [:customer, sale_items: :inventory])
                                .where('(sale_items.returned = ? AND sale_items.weight > ?) OR sale_items.returned = ?', true, 0, false)
                                .order(created_at: :desc)
                                .includes(sale: [:customer, sale_items: :inventory])
                                .first
    
      render json: @latest_invoice, include: { sale: { include: [:customer, { sale_items: { include: :inventory } }] } }
    end
    
    
    
  
    def show
      render json: @invoice
    end

  
    def create
      @invoice = Invoice.new(invoice_params)
  
      if @invoice.save
        render json: @invoice, status: :created
      else
        render json: @invoice.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @invoice.update(invoice_params)
        render json: @invoice
      else
        render json: @invoice.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @invoice.destroy
      head :no_content
    end
  
    private
  
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end
  
    def invoice_params
      params.require(:invoice).permit(:sale_id, :number, :date, :total,:status)
    end
end
