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

    puts "以下０だよ"
    puts test[3]
    # puts test[7]
    # puts test[14]

    dates = []
    test.each do |date|
      if date[:id] % 7 == 1
      	dates << date[:data]
      end
    end

    start_value = []
    test.each do |start|
      if start[:id] % 7 == 3
        start_value << start[:data]
        get_start_value

      end
    end
    
    high_value = []
    test.each do |high|
      if high[:id] % 7 == 4
        high_value << high[:data]
      end
    end

    low_value = []
    test.each do |low|
      if low[:id] % 7 == 5
        low_value << low[:data]
      end
    end

    end_value = []
    test.each do |finish|
      if finish[:id] % 7 == 6
        end_value << finish[:data]
      end
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

    def self.get_start_value
    id = 1
    start_value.each do |start|
    stock = Stock.where(id:id).first_or_initialize
    stock.date = start
    id += 1
    stock.save
     end
   end

    # stock = Stock.new(stock: dates, start_value: start_value, high_value: high_value, low_value: low_value, end_value: end_value)
    # stock.save
end