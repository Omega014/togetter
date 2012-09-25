require 'csv'
a = []

CSV.foreach('noun.csv') do |str|

a << str
end
puts a[0]