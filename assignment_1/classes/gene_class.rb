class Gene   
    attr_accessor :gene_id
    attr_accessor :gene_name
    attr_accessor :mutant_phenotype
    attr_accessor :correlated_genes
    attr_accessor :chi_squared
    
    def initialize (params = {}) 
      @gene_id = params.fetch(:gene_id, nil)
      @gene_name = params.fetch(:gene_name, nil)
      @mutant_phenotype = params.fetch(:mutant_phenotype, nil)
      @correlated_genes = params.fetch(:correlated_genes, 'none')
      @chi_squared = params.fetch(:chi_squared, nil)
      #creating a regex that matches the cirrect gene format 
      #implement it as we have seen in class for the disease class exercise
      match_id = /A[Tt]\d[Gg]\d\d\d\d\d/ 
      unless match_id.match(@gene_id)
            puts"[ERROR]: check your gene id because it does not match the standard nomenclature: #{@gene_id}"
      
    end
    
      
    end
    
    def self.find_gene(genes,id) #Find gene by ID
      genes.each do |gene|
          if gene[1].gene_id == id
            return gene[1]
          end
      end
    end
  
  
    def correlated_gene=(gene) #function to add the correlate gene in the correlated gene attibute (this is so ugly i am sorry )
          @correlated_genes = gene
    end
    
    def chi_squared=(chi_squared) #same but for chi sqaured 
          @chi_squared = chi_squared
    end
  
  end
