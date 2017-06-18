class Scraping
  def self.stock_score
    agent = Mechanize.new
    page = agent.get("http://k-db.com/futures/F101-0000/4h/2017")
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
      if date[:id] % 9 == 1
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
      if start[:id] % 9 == 3
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
      if high[:id] % 9 == 4
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
      if low[:id] % 9 == 5
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
      if finish[:id] % 9 == 6
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

    # 時間スクレイピング
    times = []
    test.each do |time|
      if time[:id] % 9 == 2
        times << time[:data]
      end
    end

    # 終値保存
    j = 0
    times.reverse!
    times.each do |time|
      stock[j][:times] = time
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
    Atr.calculate
    Kagi.calculate
  end
    # puts end_value.length
    # puts end_value

    # puts "ここから下は日付をまとめた配列"
    # puts dates
    # puts "ここから下は始値をまとめた配列"
    # puts start_value
    # puts "ここから下は高値をまとめた配列"
    # puts high_value
    # puts "ここから下は安値をまとめた配列"
    # puts low_value
    # puts "ここから下は終値をまとめた配列"
    # puts end_value
end

  # def self.get_start_value(start_value)
  #     puts "get_start_value"
  #     start_value.each do |start|
  #       puts start
  #       stock = Stock.new
  #       stock.start_value = start
  #       stock.save
  #     end
  # end