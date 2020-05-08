require 'test_helper'

class FinancialAssetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @financial_asset = financial_assets(:one)
  end

  test "should get index" do
    get financial_assets_url
    assert_response :success
  end

  test "should get new" do
    get new_financial_asset_url
    assert_response :success
  end

  test "should create financial_asset" do
    assert_difference('FinancialAsset.count') do
      post financial_assets_url, params: { financial_asset: { ticker_symbol: @financial_asset.ticker_symbol } }
    end

    assert_redirected_to financial_asset_url(FinancialAsset.last)
  end

  test "should show financial_asset" do
    get financial_asset_url(@financial_asset)
    assert_response :success
  end

  test "should get edit" do
    get edit_financial_asset_url(@financial_asset)
    assert_response :success
  end

  test "should update financial_asset" do
    patch financial_asset_url(@financial_asset), params: { financial_asset: { ticker_symbol: @financial_asset.ticker_symbol } }
    assert_redirected_to financial_asset_url(@financial_asset)
  end

  test "should destroy financial_asset" do
    assert_difference('FinancialAsset.count', -1) do
      delete financial_asset_url(@financial_asset)
    end

    assert_redirected_to financial_assets_url
  end
end
