class TradeConfigsController < ApplicationController
  before_action :set_trade_config, only: [:show, :edit, :update, :destroy]

  # GET /trade_configs
  # GET /trade_configs.json
  def index
    @trade_configs = TradeConfig.all
  end

  # GET /trade_configs/1
  # GET /trade_configs/1.json
  def show
  end

  # GET /trade_configs/new
  def new
    @trade_config = TradeConfig.new
  end

  # GET /trade_configs/1/edit
  def edit
  end

  # POST /trade_configs
  # POST /trade_configs.json
  def create
    @trade_config = TradeConfig.new(trade_config_params)

    respond_to do |format|
      if @trade_config.save
        format.html { redirect_to trade_configs_url, notice: '交易配置创建成功' }
        format.json { render :show, status: :created, location: @trade_config }
      else
        format.html { render :new }
        format.json { render json: @trade_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trade_configs/1
  # PATCH/PUT /trade_configs/1.json
  def update
    respond_to do |format|
      if @trade_config.update(trade_config_params)
        format.html { redirect_to trade_configs_url, notice: '交易配置更新成功' }
        format.json { render :show, status: :ok, location: @trade_config }
      else
        format.html { render :edit }
        format.json { render json: @trade_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trade_configs/1
  # DELETE /trade_configs/1.json
  def destroy
    @trade_config.destroy
    respond_to do |format|
      format.html { redirect_to trade_configs_url, notice: '交易配置删除成功' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trade_config
      @trade_config = TradeConfig.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trade_config_params
      params.require(:trade_config).permit(:symbol, :size, :ratio)
    end
end
