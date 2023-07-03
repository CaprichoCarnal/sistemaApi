class Api::V1::DocumentTypesController < ApplicationController
    before_action :set_document_type, only: [:show, :update, :destroy]

    # GET /api/v1/document_types
    def index
      @document_types = DocumentType.all
      render json: @document_types
    end
  
    # GET /api/v1/document_types/:id
    def show
      render json: @document_type
    end
  
    # POST /api/v1/document_types
    def create
      @document_type = DocumentType.new(document_type_params)
  
      if @document_type.save
        render json: @document_type, status: :created
      else
        render json: @document_type.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/document_types/:id
    def update
      if @document_type.update(document_type_params)
        render json: @document_type
      else
        render json: @document_type.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/document_types/:id
    def destroy
      @document_type.destroy
      head :no_content
    end
  
    private
  
    def set_document_type
      @document_type = DocumentType.find(params[:id])
    end
  
    def document_type_params
      params.require(:document_type).permit(:name)
    end
end
