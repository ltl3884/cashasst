require 'test_helper'

class TradeConfigsControllerTest < ActionController::TestCase
  setup do
    @trade_config = trade_configs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trade_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trade_config" do
    assert_difference('TradeConfig.count') do
      post :create, trade_config: { ratio: @trade_config.ratio, size: @trade_config.size, symbol: @trade_config.symbol }
    end

    assert_redirected_to trade_config_path(assigns(:trade_config))
  end

  test "should show trade_config" do
    get :show, id: @trade_config
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trade_config
    assert_response :success
  end

  test "should update trade_config" do
    patch :update, id: @trade_config, trade_config: { ratio: @trade_config.ratio, size: @trade_config.size, symbol: @trade_config.symbol }
    assert_redirected_to trade_config_path(assigns(:trade_config))
  end

  test "should destroy trade_config" do
    assert_difference('TradeConfig.count', -1) do
      delete :destroy, id: @trade_config
    end

    assert_redirected_to trade_configs_path
  end
end
