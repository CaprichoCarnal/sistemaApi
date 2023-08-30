class Api::V1::ElaboratedProductsController < ApplicationController
  before_action :set_elaborated_product, only: [:show, :update, :destroy]

  # GET /api/v1/elaborated_products
   def index
    @elaborated_products = ElaboratedProduct.order(created_at: :desc).all

    response_data = @elaborated_products.map do |elaborated_product|
      matching_article = ArticleName.find_by(name: elaborated_product.name)
      article_data = nil

      if matching_article
        article_data = {
          family_id: matching_article.family_id,
          code: matching_article.code,
          article_name: matching_article.name,
          ingredients: matching_article.ingredients,
          energy_value: matching_article.energy_value,
          fats: matching_article.fats,
          saturated_fats: matching_article.saturated_fats,
          carbohydrates: matching_article.carbohydrates,
          sugars: matching_article.sugars,
          proteins: matching_article.proteins,
          salt: matching_article.salt        }
      end

      {
        id: elaborated_product.id,
        name: elaborated_product.name,
        weight: elaborated_product.weight,
        lot: elaborated_product.lot,
        description: elaborated_product.description,
        cut_id: elaborated_product.cut_id,
        created_at: elaborated_product.created_at,
        updated_at: elaborated_product.updated_at,
        frozen: elaborated_product.frozen,
        expiration_date: elaborated_product.expiration_date,
        weight_used: elaborated_product.weight_used,
        cut: elaborated_product.cut,
        elaborated_product_materials: elaborated_product.elaborated_product_materials,
        article_data: article_data # Agrega datos de artículo
      }
    end

    render json: response_data
  end
  # GET /api/v1/elaborated_products/1
  def show
    render json: @elaborated_product, include: [:cut, elaborated_product_materials: { include: :supply }]
  end



  # POST /api/v1/elaborated_products
   def create
    @elaborated_product = ElaboratedProduct.new(elaborated_product_params)

    if @elaborated_product.save
      matching_article = ArticleName.find_by(name: @elaborated_product.name)
      article_data = nil

      if matching_article
        article_data = {
          family_id: matching_article.family_id,
          code: matching_article.code,
          article_name: matching_article.name,
          ingredients: matching_article.ingredients,
          energy_value: matching_article.energy_value,
          fats: matching_article.fats,
          saturated_fats: matching_article.saturated_fats,
          carbohydrates: matching_article.carbohydrates,
          sugars: matching_article.sugars,
          proteins: matching_article.proteins,
          salt: matching_article.salt
          # Agrega más atributos según tus necesidades
        }
      end

      response_data = {
        id: @elaborated_product.id,
        name: @elaborated_product.name,
        weight: @elaborated_product.weight,
        lot: @elaborated_product.lot,
        description: @elaborated_product.description,
        cut_id: @elaborated_product.cut_id,
        created_at: @elaborated_product.created_at,
        updated_at: @elaborated_product.updated_at,
        frozen: @elaborated_product.frozen,
        expiration_date: @elaborated_product.expiration_date,
        weight_used: @elaborated_product.weight_used,
        cut: @elaborated_product.cut,
        elaborated_product_materials: @elaborated_product.elaborated_product_materials,
        article_data: article_data # Agrega datos de artículo
      }

      render json: response_data, status: :created, location: api_v1_elaborated_product_url(@elaborated_product)
    else
      render json: @elaborated_product.errors, status: :unprocessable_entity
    end
  end



  # PATCH/PUT /api/v1/elaborated_products/1
  def update
    if @elaborated_product.update(elaborated_product_params)
      render json: @elaborated_product
    else
      render json: @elaborated_product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/elaborated_products/1
  def destroy
    @elaborated_product.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_elaborated_product
    @elaborated_product = ElaboratedProduct.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def elaborated_product_params
    params.require(:elaborated_product).permit(:name, :description, :lot, :weight ,:prepared_by ,:cut_id, :frozen, :expiration_date ,:weight_used,elaborated_product_materials_attributes: [:id, :supply_id, :quantity, :_destroy])
  end
end
