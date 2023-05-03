class Api::V1::PieceNamesController < ApplicationController
    before_action :set_piecename, only: [:show, :edit, :update, :destroy]

    def index
        @piecenames = Piecename.includes(:family).all
        render json: @piecenames.to_json(include: { family: { only: :name } })
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
