class Api::V1::UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]

    # GET /api/v1/users
    def index
      @users = User.all
      render json: @users.to_json(include: { role: { only: :name } })
    end
  
    # GET /api/v1/users/:id
    def show
      render json: @user.to_json(include: { role: { only: :name } })
    end
  
    # POST /api/v1/users
    def create
      @user = User.new(user_params)
  
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH /api/v1/users/:id
    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:id
    def destroy
      @user.destroy
      head :no_content
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.permit(:name, :email, :password, :role_id)
    end
end
