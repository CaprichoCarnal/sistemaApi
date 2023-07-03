class Api::V1::PieceNamesController < ApplicationController
    before_action :set_piecename, only: [:show, :edit, :update, :destroy]

    def index
      @piecenames = Piecename.includes(:family).all.group_by(&:family_id)

      # Obtener los nombres de las familias correspondientes a los family_id
      family_names = Family.where(id: @piecenames.keys).pluck(:id, :name).to_h
    
      # Reemplazar los family_id con los nombres correspondientes en cada grupo
      @piecenames.transform_keys! { |family_id| family_names[family_id] }
    
      # Construir un nuevo hash excluyendo las propiedades created_at y updated_at
      result = @piecenames.transform_values do |pieces|
        pieces.map { |piece| piece.as_json(except: [:created_at, :updated_at]) }
      end
    
      render json: result.to_json(include: { family: { only: :name } })
    end

  def show
    render json: @piecename
  end

  def new
    @piecename = Piecename.new
  end

  def create
    @piecename = Piecename.new(piecename_params)
    if @piecename.save
      render json: @piecename, status: :created, location: @piecename
    else
      render json: @piecename.errors, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @piecename.update(piecename_params)
      render json: @piecename
    else
      render json: @piecename.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @piecename.destroy
    head :no_content
  end

  private

  def set_piecename
    @piecename = Piecename.find(params[:id])
  end

  def piecename_params
    params.permit(:name, :family_id)
  end
end
