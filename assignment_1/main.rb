#import needed libraries for my code 
require 'date'
require 'csv'
#initialize file names 
gene_file = 'gene_information.tsv'
seed_file = 'seed_stock_data.tsv'
cross_file = 'cross_data.tsv'

# #import needed classes 
require './classes/gene_class.rb'
require './classes/seed_class.rb'
require './classes/cross_class.rb'

#load gene objects from file
gene_table = CSV.read(gene_file, headers: true, col_sep: "\t") #Read tsv file
genes = {}
gene_table.each() do |row|
  genes[row['Gene_ID'].downcase] = Gene.new( 
  :gene_id => row['Gene_ID'], 
  :gene_name => row['Gene_name'], 
  :mutant_phenotype => row['mutant_phenotype'])
end

#load seeds objects from file 
seed_table = CSV.read(seed_file, headers: true, col_sep: "\t") #Read tsv file
seeds={}

seed_table.each() do |row|
  seeds[row["Seed_Stock"].downcase]=Seed.new( 
  :gene_id => row["Mutant_Gene_ID"], 
  :last_planted => row['Last_Planted'], 
  :storage => row["Storage"],
  :grams_remaining => row["Grams_Remaining"].to_i,
  :seed_stock => row["Seed_Stock"])
end

#load crosses objects from file 
cross_table = CSV.read(cross_file, headers: true, col_sep: "\t") #Read tsv file
crosses = {}

cross_table.each() do |row|
  crosses[row["Parent1"] + "+" + row["Parent2"]] = Cross.new( 
  :parent1 => row['Parent1'], 
  :parent2 => row['Parent2'], 
  :f2_wild => row['F2_Wild'].to_f,
  :f2_p1 => row['F2_P1'].to_f,
  :f2_p2 => row['F2_P2'].to_f,
  :f2_p1p2 => row['F2_P1P2'].to_f)
end 

#i am sorry I created objects dynamically from files in this way, I am sure there are better ways

#planting seeds 
how_many= 7
seeds.each() do |seed|
    seed[1].plant(how_many)
    puts '---------------------------------------------------------------'
end

#creating updated tsv file
#I get the header of the old file then I fill the rows using the new updated attributes from my objects  
old_stock_table = CSV.read(seed_file, headers: true, col_sep: "\t") #Read tsv file
stock_header = old_stock_table.headers
new_table = File.open('new_stock_file.tsv', 'w')


new_table.syswrite(stock_header.join("\t"))
new_table.syswrite("\n")
seeds.each() do |seed|
  new_table.syswrite([seed[1].seed_stock, seed[1].gene_id,seed[1].last_planted,seed[1].storage, seed[1].grams_remaining,"\n"].join("\t"))#
end 
new_table = File.open('new_stock_file.tsv', 'r')


#correlation analysis
Cross.correlation_analysis(crosses,seeds,genes)
puts
#extra point
puts "lets try to create a gene object with a gene id that does not mach the regex created"
incorrect_geneid = Gene.new(
  :gene_id => "dcddfcfer", 
  :gene_name => "gapdh", 
  :mutant_phenotype => "lets invent something"
  )

