file = File.open("input3.txt")
xs = file.readlines
trees = [0, 0, 0, 0, 0]
right = [1, 3, 5, 7]
xx = 0
xs.each.with_index do |l, i|
  right.each.with_index do |r, ri|
    x = (i * r) % (l.size - 1)
    trees[ri] += 1 if l[x] == '#'
  end

  if i.even?
    trees[4] += 1 if l[xx % (l.size - 1)] == '#'
    xx += 1
  end
end

p trees
p trees.inject(:*)
