require 'test_helper'

class TradeHistoriesControllerTest < ActionController::TestCase
  setup do
    @trade_history = trade_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trade_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trade_history" do
    assert_difference('TradeHistory.count') do
      post :create, trade_history: { buy_ratio: @trade_history.buy_ratio, sell_ratio: @trade_history.sell_ratio, symbol: @trade_history.symbol }
    end

    assert_redirected_to trade_history_path(assigns(:trade_history))
  end

  test "should show trade_history" do
    get :show, id: @trade_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trade_history
    assert_response :success
  end

  test "should update trade_history" do
    patch :update, id: @trade_history, trade_history: { buy_ratio: @trade_history.buy_ratio, sell_ratio: @trade_history.sell_ratio, symbol: @trade_history.symbol }
    assert_redirected_to trade_history_path(assigns(:trade_history))
  end

  test "should destroy trade_history" do
    assert_difference('TradeHistory.count', -1) do
      delete :destroy, id: @trade_history
    end

    assert_redirected_to trade_histories_path
  end
end
