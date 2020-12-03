file = File.open("input1.txt")
xs = file.readlines.map(&:chomp).map(&:to_i)

x = xs.combination(2).select {|x| x.sum == 2020 }.first
puts x.first*x.last

x = xs.combination(3).select {|x| x.sum == 2020 }.first
puts x[0]*x[1]*x[2]
