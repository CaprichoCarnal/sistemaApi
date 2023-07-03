class Api::V1::SuppliersController < ApplicationController
    before_action :set_supplier, only: [:show, :update, :destroy]

    # GET /api/v1/suppliers
    def index
      @suppliers = Supplier.all
      render json: @suppliers
    end
  
    # GET /api/v1/suppliers/:id
    def show
      render json: @supplier
    end
  
    # POST /api/v1/suppliers
    def create
      @supplier = Supplier.new(supplier_params)
      if @supplier.save
        render json: @supplier, status: :created
      else
        render json: { errors: @supplier.errors }, status: :unprocessable_entity
      end
    end
  
    # PUT /api/v1/suppliers/:id
    def update
      if @supplier.update(supplier_params)
        render json: @supplier, status: :ok
      else
        render json: { errors: @supplier.errors }, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/suppliers/:id
    def destroy
      @supplier.destroy
      head :no_content
    end
  
    private
  
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end
  
    def supplier_params
      params.permit(:fiscal_name, :commercial_name, :address, :postal_code, :city, :province, :country, :document_type, :document, :phone, :mobile, :email)
    end
end
