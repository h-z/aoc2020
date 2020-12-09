file = File.open("input9.txt")
xs = file.readlines.map(&:to_i)

preindex = 25

invalid_index = 0

(xs.size - preindex).times do |i|
  j = preindex + i
  sums = xs[i..j-1].combination(2).map(&:sum)

  invalid_index = j unless sums.include?(xs[j])
end

p xs[invalid_index]

invalid_index.times do |i|
  (invalid_index-i).times do |j|
    xss = xs[i..j+i]
    p xss.min+xss.max if xss.sum == xs[invalid_index]
  end
end
