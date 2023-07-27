class Api::V1::CommercialAgentsController < ApplicationController
    before_action :set_commercial_agent, only: [:show, :update, :destroy]

    # GET /api/v1/commercial_agents
    def index
      @commercial_agents = CommercialAgent.all
      render json: @commercial_agents
    end
  
    # GET /api/v1/commercial_agents/:id
    def show
      render json: @commercial_agent
    end
  
    # POST /api/v1/commercial_agents
    def create
      @commercial_agent = CommercialAgent.new(commercial_agent_params)
  
      if @commercial_agent.save
        render json: @commercial_agent, status: :created
      else
        render json: @commercial_agent.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/commercial_agents/:id
    def update
      if @commercial_agent.update(commercial_agent_params)
        render json: @commercial_agent
      else
        render json: @commercial_agent.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/commercial_agents/:id
    def destroy
      @commercial_agent.destroy
      head :no_content
    end
  
    private
  
    def set_commercial_agent
      @commercial_agent = CommercialAgent.find(params[:id])
    end
  
    def commercial_agent_params
      params.permit(:code, :name, :nif, :phone, :email)
    end
end
