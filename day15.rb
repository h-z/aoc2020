file = File.open("input15.txt")
xs = file.readlines

xs = xs.first.split(',').map(&:to_i)

[2020, 30000000].each do |n|
  numbers = Hash.new {|hsh, key| hsh[key] = [] }
  mem = xs.dup

  n.times do |i|
    if i < xs.size
      mem[i] = xs[i]
    else
      elem = mem[i-1]
      if numbers[elem].size == 1
        mem[i] = 0
      else
        mem[i] = i - 1 - numbers[elem][-2]
      end
    end
    numbers[mem[i]] << i
  end
  p mem.last
end

