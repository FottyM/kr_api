class HomeController < ApplicationController
  def index
    render json: { message: 'Welcome home James' }
  end
end
