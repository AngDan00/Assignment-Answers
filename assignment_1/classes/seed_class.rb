class Seed
  attr_accessor :seed_stock
  attr_accessor :gene_id
  attr_accessor :last_planted
  attr_accessor :storage
  attr_accessor :grams_remaining
  
  
  def initialize (params = {}) 
    @gene_id = params.fetch(:gene_id, nil)
    @last_planted = params.fetch(:last_planted, nil)
    @seed_stock = params.fetch(:seed_stock, nil)
    @storage = params.fetch(:storage, nil)
    @grams_remaining = params.fetch(:grams_remaining, nil)
    #creating a regex that matches the cirrect gene format 
    #implement it as we have seen in class for the disease class exercise
    match_id = /A[Tt]\d[Gg]\d\d\d\d\d/ 
    unless match_id.match(@gene_id) 
      puts "check your #{@gene_id} because it does not corrispond to the standard notation"
      @gene_id = nil
    end
  
    
  end

  def self.find_stock(seeds,seed_stock) #Find the object with that possess the desired seed_stock 
    seeds.each do |seed|
        if seed[1].seed_stock == seed_stock
          return seed[1]
        end
    end
  end
    #function to plant seeds taking into account different results, pretty straigt forward 
   def plant(quantity) 
      seed_needed = quantity.to_i - @grams_remaining.to_i
      if (grams_remaining.to_i - quantity.to_i) > 0
        puts "before planting stock #{@seed_stock} has #{@grams_remaining} grams remaining"
        @grams_remaining = grams_remaining.to_i - quantity.to_i
        puts "#{quantity} grams Planted from stock #{@seed_stock}"
        puts "after planting stock #{@seed_stock} has #{@grams_remaining} grams remaining"
        @last_planted = DateTime.now.strftime('%-d/%-m/%Y')
        puts "last planted #{@last_planted}"
      elsif (grams_remaining.to_i - quantity.to_i) == 0
        puts "before planting stock #{@seed_stock} has #{@grams_remaining} grams remaining"
        puts "#{quantity} grams Planted from #{@seed_stock}"
        puts "[WARNING] you planted all the grams in stock #{@seed_stock}, please refill"
        @grams_remaining = 0
        @last_planted = DateTime.now.strftime('%-d/%-m/%Y')
        puts "last planted #{@last_planted}"
    else 
        puts "before planting stock #{@seed_stock} has #{@grams_remaining} grams remaining"
        puts ("[WARNING] You planted all the #{@grams_remaining} grams remaining in #{@seed_stock} stock but you still need #{seed_needed} grams to fulfill the necessity")
        @grams_remaining = 0 
        @last_planted = DateTime.now.strftime('%-d/%-m/%Y')
        puts "last planted #{@last_planted}"
    end
  end
end
