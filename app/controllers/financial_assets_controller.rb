class FinancialAssetsController < ApplicationController
  before_action :set_financial_asset, only: [:show, :edit, :update, :destroy]

  # GET /financial_assets
  # GET /financial_assets.json
  def index
    @financial_assets = FinancialAsset.all
  end

  # GET /financial_assets/1
  # GET /financial_assets/1.json
  def show
    @transactions = @financial_asset.transactions.order(:date)
    @investment_data = @financial_asset.investment_data
    @dividend_data = @financial_asset.dividend_data
    @datapoints_no_dividends = @financial_asset.datapoints_no_dividends
    @datapoints_with_dividends = @financial_asset.datapoints_with_dividends
  end

  # GET /financial_assets/new
  def new
    @financial_asset = FinancialAsset.new
  end

  # GET /financial_assets/1/edit
  def edit
  end

  # POST /financial_assets
  # POST /financial_assets.json
  def create
    @financial_asset = FinancialAsset.new(financial_asset_params)

    respond_to do |format|
      if @financial_asset.save
        format.html { redirect_to @financial_asset, notice: 'Financial asset was successfully created.' }
        format.json { render :show, status: :created, location: @financial_asset }
      else
        format.html { render :new }
        format.json { render json: @financial_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /financial_assets/1
  # PATCH/PUT /financial_assets/1.json
  def update
    respond_to do |format|
      if @financial_asset.update(financial_asset_params)
        format.html { redirect_to @financial_asset, notice: 'Financial asset was successfully updated.' }
        format.json { render :show, status: :ok, location: @financial_asset }
      else
        format.html { render :edit }
        format.json { render json: @financial_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /financial_assets/1
  # DELETE /financial_assets/1.json
  def destroy
    @financial_asset.destroy
    respond_to do |format|
      format.html { redirect_to financial_assets_url, notice: 'Financial asset was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_financial_asset
      @financial_asset = FinancialAsset.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def financial_asset_params
      params.require(:financial_asset).permit(:ticker_symbol)
    end
end
