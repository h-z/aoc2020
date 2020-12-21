file = File.open("input13.txt")
xs = file.readlines

timestamp = xs.first.to_i
ids = xs.last.split(',').map(&:to_i)

id = ids.reject(&:zero?).min_by {|x| -(timestamp % -x) }
pp id * -(timestamp % -id)

id = ids.first

100000000000000.times do |i|
  ts = id*i
  if ids.each_with_index.map { |v, idx| v.zero? ? 0 : ((ts + idx) % v) }.all?(0)
    p ts
    break
  end
end
