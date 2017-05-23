class TopController < ApplicationController
  def index
  	@top = "chartist"
  	@stocks = Stock.order('id ASC')
  end

  def new
  end

  def create
  	Top.create(stock:'toyota', start_value:'6000',high_value:'6500',low_value:'5500',end_value:'6100')
  end
end

