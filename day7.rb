file = File.open("input7.txt")
xs = file.readlines
bags = Hash.new([])

xs.each do |l|
  a, b = l.split(' bags contain ')
  bs = b.split(', ')
  bags[a] += bs.map do |bag|
    c = bag.split
    [c.first.to_i, c[1..2].join(' ')]
  end
end
found = ['shiny gold']
bags.each do
  bags.each do |bag, bags|
    if !(bags.map(&:last) & found).empty?
      found << bag
      found.uniq!
    end
  end
end

p (found - ['shiny gold']).uniq.size

def get_bags_for(bag, bags, sum)
  return sum unless bags[bag]
  sum + bags[bag].map do |b|
    b.first * get_bags_for(b.last, bags, 1)
  end.sum
end

p get_bags_for('shiny gold', bags, 0)
