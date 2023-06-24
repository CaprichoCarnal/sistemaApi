class Api::V1::VatsController < ApplicationController
  before_action :set_vat, only: [:show, :update, :destroy]

  # GET /api/v1/vats
  def index
    @vats = Vat.all
    render json: @vats
  end

  # GET /api/v1/vats/:id
  def show
    render json: @vat
  end

  # POST /api/v1/vats
  def create
    @vat = Vat.new(vat_params)

    if @vat.save
      render json: @vat, status: :created
    else
      render json: @vat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/vats/:id
  def update
    if @vat.update(vat_params)
      render json: @vat
    else
      render json: @vat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/vats/:id
  def destroy
    @vat.destroy
    head :no_content
  end

  private

  def set_vat
    @vat = Vat.find(params[:id])
  end

  def vat_params
    params.require(:vat).permit(:description, :value)
  end
end
