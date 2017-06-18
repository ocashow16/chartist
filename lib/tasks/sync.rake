namespace :sync do
  task stock_score: [:environment] do
    agent = Mechanize.new
    page = agent.get("http://k-db.com/indices/I101")
    elements = page.search('#maintable td')

    test = []
    n = 1
    elements.each do |ele|
      data_hash = {}
      data_hash[:id] = n
      data_hash[:data] = ele.inner_text
      test << data_hash
      n = n + 1
    end

      # puts "以下０だよ"
      # puts test[3]
      # puts test.last
      # puts test[7]
      # puts test[14]

      # 日付スクレイピング
      dates = []
      test.each do |date|
        if date[:id] % 7 == 1
          dates << date[:data]
        end
      end
      # puts dates.length
      # puts dates

      # 日付保存
      i = 0
      stock = []
      dates.reverse!
      dates.each do |date|
        stock[i] = Stock.new({dates:date})
        i = i+1
      end

      # 始値スクレイピング
      start_value = []
      test.each do |start|
        if start[:id] % 7 == 3
          start_value << start[:data]
        end
      end
      # puts start_value.length
      # puts start_value

      # 始値保存
      j = 0
      start_value.reverse!
      start_value.each do |start|
        stock[j][:start_value] = start
        stock[j].save
        j = j + 1
      end

      # start_value.each do |start|
      #     stock = Stock.new({start_value: start})
      #     stock.save
      # end
      # get_start_value(start_value)

      # 高値スクレイピング
      high_value = []
      test.each do |high|
        if high[:id] % 7 == 4
          high_value << high[:data]
        end
      end

      # 高値保存
      j = 0
      high_value.reverse!
      high_value.each do |high|
        stock[j][:high_value] = high
        stock[j].save
        j = j + 1
      end

      # 安値スクレイピング
      low_value = []
      test.each do |low|
        if low[:id] % 7 == 5
          low_value << low[:data]
        end
      end

      # 安値保存
      j = 0
      low_value.reverse!
      low_value.each do |low|
        stock[j][:low_value] = low
        stock[j].save
        j = j + 1
      end

      # 終値スクレイピング
      end_value = []
      test.each do |finish|
        if finish[:id] % 7 == 6
          end_value << finish[:data]
        end
      end

      # 終値保存
      j = 0
      end_value.reverse!
      end_value.each do |finish|
        stock[j][:end_value] = finish
        stock[j].save
        j = j + 1
      end


      # j = 0
      # high_value.zip(low_value).each do|highlow|
      # high1 = highlow[0].to_i - highlow[1].to_i
      # stock[j][:high_value_minus__low_value] = high1
      # stock[j].save
      # j = j + 1
      # end
      # Atr.calculate
      # Kagi.calculate
      Rake::Task["sync:atr"]
      Rake::Task["sync:atr2"]
      Rake::Task["sync:kagi"]
      Rake::Task["sync:kagi2"]
      Rake::Task["sync:kagi3"]
      Rake::Task["sync:kagi4"]
  end

  task atr: [:environment] do
    i = 2
    while i <= Stock.all.length do
      now_stock = Stock.find(i)
      before_stock = Stock.find(i-1)
      atr = Atr.where(dates: now_stock.dates).first_or_initialize
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
  end

  task atr2: [:environment] do
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

  task kagi: [:environment] do
    def self.max(a, b)
    return a if a > b
    return b
    end

    def self.min(a, b)
    return b if a > b
    return a
    end
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

  task kagi2: [:environment] do
    def self.max(a, b)
    return a if a > b
    return b
    end

    def self.min(a, b)
    return b if a > b
    return a
    end
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

  task kagi3: [:environment] do
    def self.max(a, b)
    return a if a > b
    return b
    end

    def self.min(a, b)
    return b if a > b
    return a
    end
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

  task kagi4: [:environment] do
    def self.max(a, b)
    return a if a > b
    return b
    end

    def self.min(a, b)
    return b if a > b
    return a
    end
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
  end

