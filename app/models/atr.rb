class Atr < ActiveRecord::Base
  def self.calculate
    i = 2
    while i <= Stock.all.length do
      now_stock = Stock.find(i)
      before_stock = Stock.find(i-1)
      atr = Atr.where(dates: now_stock.dates,times: now_stock.times).first_or_initialize
      atr.high_value_minus_before_end_value = (now_stock.high_value) - (before_stock.end_value)
      atr.before_end_value_minus_low_value = (before_stock.end_value) - (now_stock.low_value)
      atr.high_value_minus__low_value = (now_stock.high_value) - (now_stock.low_value)
      numbers = []
      numbers <<  atr.high_value_minus_before_end_value
      numbers <<  atr.before_end_value_minus_low_value
      numbers <<  atr.high_value_minus__low_value
      atr.true_range = numbers.max
      atr.dates = now_stock.dates
      atr.save
      i += 1;
    end
    cal_atr
  end

  def self.cal_atr
    i = 1
    atr = Atr.find(i)
    atr.average_true_range = 0
    atr.save
    i += 1
      while i<Stock.all.length do
        now_atr = Atr.find(i)
        after_atr = Atr.find(i-1)
        # atr = Atr.where(id: i).first_or_initialize
        now_atr.average_true_range = (((now_atr.true_range) * 2)+((after_atr.average_true_range) * 19))/21
        now_atr.save
        i += 1
      end
  end
end
