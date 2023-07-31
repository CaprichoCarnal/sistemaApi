class Api::V1::MixCutsController < ApplicationController
    before_action :set_mix_cut, only: [:show, :update, :destroy]

    # GET /api/v1/mix_cuts
    def index
      @mix_cuts = MixCut.order(created_at: :desc).all
      render json: @mix_cuts, include: [:cut, mixed_cut: { include: :cut }]
    end
  
    # GET /api/v1/mix_cuts/1
    def show
      render json: @mix_cut
    end
  
    # POST /api/v1/mix_cuts
    def create
      @mix_cut = MixCut.new(mix_cut_params)
      if @mix_cut.save
        render json: @mix_cut, status: :created, location: api_v1_mix_cut_url(@mix_cut)
      else
        render json: @mix_cut.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/mix_cuts/1
    def update
      if @mix_cut.update(mix_cut_params)
        render json: @mix_cut
      else
        render json: @mix_cut.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/mix_cuts/1
    def destroy
      @mix_cut.destroy
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_mix_cut
      @mix_cut = MixCut.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through.
    def mix_cut_params
      params.require(:mix_cut).permit(:name, :weight, :lot, :cut_id, :frozen, :expiration_date, mixed_cut_attributes: [:id, :cut_id, :weight])
    end

    

end
