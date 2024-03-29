class Api::V1::CustomersController < ApplicationController
    before_action :set_customer, only: [:show, :update, :destroy]

    # GET /api/v1/customers
    def index
      @customers = Customer.includes(:commercial_agent).all
      render json: @customers, include: :commercial_agent
    end
    
  
    # GET /api/v1/customers/:id
    def show
      render json: @customer
    end
  
    # POST /api/v1/customers
    def create
      @customer = Customer.new(customer_params)
  
      if @customer.save
        render json: @customer, status: :created
      else
        render json: @customer.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/customers/:id
    def update
      if @customer.update(customer_params)
        render json: @customer
      else
        render json: @customer.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/customers/:id
    def destroy
      @customer.destroy
      head :no_content
    end
  
    private
  
    def set_customer
      @customer = Customer.find(params[:id])
    end
  
    def customer_params
      params.permit(:fiscal_name, :commercial_name, :address, :postal_code, :city, :province, :country, :document_type, :document, :name, :phone, :mobile, :email, :bank,:commercial_agent_id)
    end
end
