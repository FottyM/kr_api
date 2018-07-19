# app/controllers/portfolios_controller.rb
class PortfoliosController < ApplicationController
  before_action :set_portfolio

  def index
    @portfolios = current_user.portfolios.all
  end

  def create
    @portfolio = current_user.portfolios.new(portfolio_params)

    if @portfolio.save
      render json: @portfolio, status: :created
    else
      render json: @portfolio.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @portfolio
  end

  def update
    if @portfolio.update(portfolio_params)
      render json: @portfolio
    else
      render json: @portfolio.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @portfolio.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_portfolio
    @portfolio = current_user.portfolios.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def portfolio_params
    params.require(:portfolio)
          .permit(:cryptocurrency, :amount, :date_of_purchase,
                  :wallet_location, :current_market_value)
  end
end
