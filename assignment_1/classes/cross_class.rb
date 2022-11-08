class Cross  
    attr_accessor :parent1
    attr_accessor :parent2
    attr_accessor :f2_wild
    attr_accessor :f2_p1
    attr_accessor :f2_p2
    attr_accessor :f2_p1p2
    
    
    def initialize (params = {}) 
      @parent1 = params.fetch(:parent1, nil)
      @parent2 = params.fetch(:parent2, nil)
      @f2_wild = params.fetch(:f2_wild, nil)
      @f2_p1 = params.fetch(:f2_p1, nil)
      @f2_p2 = params.fetch(:f2_p2, nil)
      @f2_p1p2 = params.fetch(:f2_p1p2, nil)
      
    end
    
    def self.correlation_analysis(crosses,seeds,genes)
      crosses.each() do |cross|
        sum_row = cross[1].f2_wild + cross[1].f2_p1 + cross[1].f2_p2 + cross[1].f2_p1p2
        #calculating expecting value based on the mendelian ratio (calculate the total of the row then multiply for the ratios to get the expected values) what we have in the cross file are the observed values
        expected_wild = sum_row * 9/16 #Different expected values
        expected_f2_p1 = sum_row * 3/16
        expected_f2_p2 = sum_row * 3/16
        expected_f2_p1p2 = sum_row * 1/16
        #applying chi_squared formula χ2 = ∑(Oi – Ei)2/Ei
        chi_squared = ( (cross[1].f2_wild - expected_wild)**2/expected_wild  +
                              (cross[1].f2_p1 - expected_f2_p1)**2/expected_f2_p1 +
                              (cross[1].f2_p2 - expected_f2_p2)**2/expected_f2_p2 +
                              (cross[1].f2_p1p2 - expected_f2_p1p2)**2/expected_f2_p1p2 )
        #select a threashold from the t-table that  corresponds to the 95%, when this threashold is satified the genes are linked in a statistically significant way 
        if chi_squared > 7.815
            puts "Match Found! #{cross[1].parent1} is linked to #{cross[1].parent2} with a chi-square score of #{chi_squared}"
            #find gene id that corresponds to the parent1 and parent2
            id_linked1 = Seed.find_stock(seeds, cross[1].parent1).gene_id
            id_linked2 = Seed.find_stock(seeds, cross[1].parent2).gene_id
            #find gene name associated to that gene_id
            name_linked1 = Gene.find_gene(genes,id_linked1).gene_name
            name_linked2 = Gene.find_gene(genes,id_linked2).gene_name
            puts            
            puts "Elaborating results.."
            puts
            puts "#{genes[id_linked1.downcase].gene_name} is linked with #{genes[id_linked2.downcase].gene_name}"       
            puts "#{genes[id_linked2.downcase].gene_name} is linked with #{genes[id_linked1.downcase].gene_name}"
            puts            
            genes[id_linked1.downcase].correlated_gene=(name_linked2)
            genes[id_linked1.downcase].chi_squared=chi_squared
            genes[id_linked2.downcase].correlated_gene=(name_linked1)
            genes[id_linked2.downcase].chi_squared=chi_squared
  
  
        else 
          puts "no match found for #{cross[1]}"
        end 
      end 
    end 
  
  end
