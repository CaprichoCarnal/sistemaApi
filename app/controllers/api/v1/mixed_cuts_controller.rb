class Api::V1::MixedCutsController < ApplicationController
    before_action :set_mixed_cut, only: [:show, :update, :destroy]

    # GET /api/v1/mixed_cuts
    def index
      @mixed_cuts = MixedCut.order(created_at: :desc).all
      render json: @mixed_cuts
    end
  
    # GET /api/v1/mixed_cuts/1
    def show
      render json: @mixed_cut
    end
  
    # POST /api/v1/mixed_cuts
    def create
      @mixed_cut = MixedCut.new(mixed_cut_params)
      if @mixed_cut.save
        render json: @mixed_cut, status: :created, location: api_v1_mixed_cut_url(@mixed_cut)
      else
        render json: @mixed_cut.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/mixed_cuts/1
    def update
      if @mixed_cut.update(mixed_cut_params)
        render json: @mixed_cut
      else
        render json: @mixed_cut.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/mixed_cuts/1
    def destroy
      @mixed_cut.destroy
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_mixed_cut
      @mixed_cut = MixedCut.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through.
    def mixed_cut_params
      params.require(:mixed_cut).permit(:mix_cut_id, :cut_id, :weight)
    end
end
