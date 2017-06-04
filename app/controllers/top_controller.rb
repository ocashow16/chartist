class TopController < ApplicationController
  def index
  	@top = "chartist"
  	@stocks = Model.order('date ASC').group(:date).count
  end
end

