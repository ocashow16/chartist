class TopController < ApplicationController
  def index
  	# @top = "chartist"
  	# @stocks = Stock.order('dates ASC').group(:dates).count
   #  @stocks = Stock.order('dates ASC').group(:dates).sum(:end_value)

    i = Kagi.all.length
    num = (Kagi.find(i).index) * 2 - 2
    @kagis = Kagi.limit(num)
    @datas = []
    
    @kagis.each do |kagi|
      data = []
      data << kagi.x
      data << kagi.kagi_ashi
      @datas << data
    end
    @datas_j = @datas.to_json.html_safe
  end

  def index2

    @stocks.each do |stock|
      data = []
      data << stock.dates.to_s
      data << stock.low_value
      data << stock.end_value
      data << stock.start_value
      data << stock.high_value
      @datas << data
      
    end
    @datas_j = @datas.to_json.html_safe
  end
end

