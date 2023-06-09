class Api::V1::ArticleNamesController < ApplicationController
    before_action :set_article_name, only: [:show, :update, :destroy]
  
    # GET /article_names
    def index
      @article_names = ArticleName.all
      render json: @article_names
    end
  
    # GET /article_names/1
    def show
      render json: @article_name
    end
  
    # POST /article_names
    def create
      @article_name = ArticleName.new(article_name_params)
  
      if @article_name.save
        render json: @article_name, status: :created
      else
        render json: @article_name.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /article_names/1
    def update
      if @article_name.update(article_name_params)
        render json: @article_name
      else
        render json: @article_name.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /article_names/1
    def destroy
      @article_name.destroy
      head :no_content
    end
  
    private
  
    def set_article_name
      @article_name = ArticleName.find(params[:id])
    end
  
    def article_name_params
      params.permit(:name, :family_id, :code)
    end
  end
  