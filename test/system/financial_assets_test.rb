require "application_system_test_case"

class FinancialAssetsTest < ApplicationSystemTestCase
  setup do
    @financial_asset = financial_assets(:one)
  end

  test "visiting the index" do
    visit financial_assets_url
    assert_selector "h1", text: "Financial Assets"
  end

  test "creating a Financial asset" do
    visit financial_assets_url
    click_on "New Financial Asset"

    fill_in "Ticker symbol", with: @financial_asset.ticker_symbol
    click_on "Create Financial asset"

    assert_text "Financial asset was successfully created"
    click_on "Back"
  end

  test "updating a Financial asset" do
    visit financial_assets_url
    click_on "Edit", match: :first

    fill_in "Ticker symbol", with: @financial_asset.ticker_symbol
    click_on "Update Financial asset"

    assert_text "Financial asset was successfully updated"
    click_on "Back"
  end

  test "destroying a Financial asset" do
    visit financial_assets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Financial asset was successfully destroyed"
  end
end
