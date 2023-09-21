class Api::V1::CutsController < ApplicationController

        before_action :set_cut, only: [:show, :update, :destroy]
      
        def index
          @cuts = Cut.includes(:raw_material).where("weight > ?", 0).order(created_at: :desc).all
          render json: @cuts.to_json(include: { raw_material: { only: [:name, :crotal, :lot, :slaughter_date, :born_date, :slaughtered_in, :classification, :born_in,  ] } })

        end
      
        def show
          render json: @cut
        end
        def create
          cuts = params[:cuts]
          @created_cuts = []
        
          cuts.each do |cut_params|
            cut = Cut.new(cut_params.permit(:name, :lot, :weight, :matured, :maturity_start_date, :maturity_end_date, :frozen, :available_for_sale, :prepared_by, :raw_material_id, :expiration_date, :finished))
            if cut.save
              @created_cuts << cut
            end
          end
        
          if @created_cuts.present?
            render json: @created_cuts, status: :created, include: { raw_material: { only: [:name, :crotal, :lot, :slaughter_date, :born_date, :slaughtered_in, :classification, :born_in] } }
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
          params.require(:cut).permit(:name, :lot ,:weight, :matured, :maturity_start_date, :maturity_end_date, :frozen, :available_for_sale, :prepared_by, :raw_material_id,:expiration_date,:finished)
        end
     
end
