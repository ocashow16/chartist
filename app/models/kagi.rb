class Kagi < ActiveRecord::Base

  def self.calculate
    trend
    kakutei
    cal_index
    ashi
  end

  def self.trend
    now = Stock.find(1).end_value
    kagi = Kagi.where(id: 1).first_or_initialize
    kagi.trend = 1
    kagi.zantei = now
    kagi.kakutei = now
    kagi.index = 1
    kagi.x = 1
    kagi.kagi_ashi = now
    kagi.save
    i = 2
    atr = Atr.find(Atr.all.length).average_true_range * 1.3
    while i <= Stock.all.length do
      now_stock = Stock.find(i)
      before_kagi = Kagi.find(i-1)
      ans = (now_stock.end_value) - (before_kagi.zantei)
      kagi = Kagi.where(id: i).first_or_initialize
      # 今日のtrendを求める
      if(before_kagi.trend == 1)
        if(ans > atr * (-1))
          kagi.trend = before_kagi.trend
        else
          kagi.trend = -1
        end
      else
        if(ans < atr)
          kagi.trend = before_kagi.trend
        else
          kagi.trend = 1
        end
      end
      # 今日の暫定を求める
      if(kagi.trend == 1)
        kagi.zantei = max(before_kagi.zantei , now_stock.end_value)
      else
        kagi.zantei = min(before_kagi.zantei , now_stock.end_value)
      end
      kagi.save
      i += 1
    end
  end

  def self.kakutei
    i = Kagi.all.length
    kagi = Kagi.find(i)
    kagi.update(kakutei: kagi.zantei)
    i -= 1
    while i>0 do
      kagi = Kagi.find(i)
      if(kagi.trend == 1)
        kagi.kakutei = max(kagi.zantei , Kagi.find(i+1).kakutei)
      else
        kagi.kakutei = min(kagi.zantei , Kagi.find(i+1).kakutei)
      end
      kagi.save
      i -= 1
    end
  end

  def self.cal_index
    i = 2
    kagi = Kagi.find(i)
    before_kagi = Kagi.find(i-1)
    if(kagi.kakutei == before_kagi.kakutei)
      kagi.index = before_kagi.index
    else
      kagi.index = before_kagi.index + 1
    end
    kagi.x = 1
    kagi.save
    i += 1
    while i<=Kagi.all.length do
      kagi = Kagi.find(i)
      before_kagi = Kagi.find(i-1)
      if(kagi.kakutei == before_kagi.kakutei)
        kagi.index = before_kagi.index
      else
        kagi.index = before_kagi.index + 1
      end
      kagi.x = Kagi.find(i-2).x + 1
      kagi.save
      i += 1
    end
  end

  def self.ashi
    # index最大値を取得
    i = Kagi.all.length
    kagi = Kagi.find(i)
    max_index = kagi.index
    ashis = []
    #i初期化
    i = 1
    while i<=max_index do
      ashis << Kagi.find_by(index: i).kakutei
      i += 1
    end

    #i初期化
    i = 1
    kagi = Kagi.find(i)
    kagi.kagi_ashi = ashis[i-1]
    kagi.save
    i += 1
    j = 2
    while i < max_index do
      kagi1 = Kagi.find(j)
      j += 1
      kagi2 = Kagi.find(j)
      j += 1
      kagi1.kagi_ashi = ashis[i-1]
      kagi2.kagi_ashi = ashis[i-1]
      kagi1.save
      kagi2.save
      i += 1
    end
    kagi = Kagi.find(j)
    kagi.kagi_ashi = ashis[i-1]
    kagi.save
  end

  def self.max(a, b)
    return a if a > b
    return b
  end

  def self.min(a, b)
    return b if a > b
    return a
  end

end
