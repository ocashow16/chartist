class Money
  def self.stock_score
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

    # 日付スクレイピング
    dates = []
    test.each do |date|
      if date[:id] % 7 == 1
        dates << date[:data]
      end
    end

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

    # 始値保存
    j = 0
    start_value.reverse!
    start_value.each do |start|
      stock[j][:start_value] = start
      puts start
      j = j + 1
    end

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
      j = j + 1
    end

    j = 0
    high_value.zip(low_value).each do|highlow|
      high1 = highlow[0].to_i - highlow[1].to_i
      stock[j][:high_value_minus__low_value] = high1
    end
  end
end
