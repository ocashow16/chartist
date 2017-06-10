  class Scraping
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

    # puts "以下０だよ"
    # puts test[3]
    # puts test.last
    # puts test[7]
    # puts test[14]

    dates = []
    test.each do |date|
      if date[:id] % 7 == 1
      	dates << date[:data]
      end
    end
    # puts dates.length
    # puts dates

    i = 0
    stock = []

    dates.each do |date|
      stock[i] = Stock.new({dates:date})
      i = i+1
    end

    start_value = []
    test.each do |start|
      if start[:id] % 7 == 3
        start_value << start[:data]
      end
    end
    # puts start_value.length
    # puts start_value

    j = 0

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

    high_value = []
    test.each do |high|
      if high[:id] % 7 == 4
        high_value << high[:data]
      end
    end

    j = 0

    high_value.each do |high|
      stock[j][:high_value] = high
      stock[j].save
      j = j + 1
    end

    low_value = []
    test.each do |low|
      if low[:id] % 7 == 5
        low_value << low[:data]
      end
    end

    j = 0

    low_value.each do |low|
      stock[j][:low_value] = low
      stock[j].save
      j = j + 1
    end

    end_value = []
    test.each do |finish|
      if finish[:id] % 7 == 6
        end_value << finish[:data]
      end
    end
    # puts end_value.length
    # puts end_value

    j = 0

    end_value.each do |finish|
      stock[j][:end_value] = finish
      stock[j].save
      j = j + 1
    end
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
end