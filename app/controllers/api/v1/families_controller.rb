class Api::V1::FamiliesController < ApplicationController
    before_action :set_family, only: [:show, :update, :destroy]

    # GET /api/v1/families
    def index
      @families = Family.all
      render json: @families
    end
  
    # GET /api/v1/families/:id
    def show
      render json: @family
    end
  
    # POST /api/v1/families
    def create
      @family = Family.new(family_params)
  
      if @family.save
        render json: @family, status: :created
      else
        render json: @family.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH /api/v1/families/:id
    def update
      if @family.update(family_params)
        render json: @family
      else
        render json: @family.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/families/:id
    def destroy
      @family.destroy
      head :no_content
    end
  
    private
  
    def set_family
      @family = Family.find(params[:id])
    end
  
    def family_params
      params.require(:family).permit(:code, :name)
    end
end
