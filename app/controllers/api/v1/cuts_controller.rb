class Api::V1::CutsController < ApplicationController

        before_action :set_cut, only: [:show, :update, :destroy]
      
        def index
          @cuts = Cut.includes(:raw_material).all
          render json: @cuts.to_json(include: { raw_material: { only: [:name, :crotal] } })
        end
      
        def show
          render json: @cut
        end
      
        def create
          cuts = params[:cuts]
          @cuts = []
      
          cuts.each do |cut_params|
            cut = Cut.new(cut_params.permit(:name, :lot ,:weight, :matured, :maturity_start_date, :maturity_end_date, :frozen, :available_for_sale, :prepared_by, :raw_material_id))
            @cuts << cut if cut.save
          end
      
          if @cuts.present?
            render json: @cuts, status: :created
          else
            render json: { error: "No se pudieron crear los cortes" }, status: :unprocessable_entity
          end
        end
      
        def update
          if @cut.update(cut_params)
            render json: @cut
          else
            render json: @cut.errors, status: :unprocessable_entity
          end
        end
      
        def destroy
          @cut.destroy
          head :no_content
        end
      
        private
      
        def set_cut
          @cut = Cut.find(params[:id])
        end
      
        def cut_params
          params.require(:cut).permit(:name, :lot ,:weight, :matured, :maturity_start_date, :maturity_end_date, :frozen, :available_for_sale, :prepared_by, :raw_material_id)
        end
     
end
