file = File.open("input10.txt")
xs = file.readlines.map(&:to_i).sort
xs = xs.map.with_index do |e,i|
  f = i == 0 ? 0 : xs[i-1]
  e-f
end
xs << 3
p xs.count(1) * (xs.count(3))

tt = [1,1,1,2,4,7,13]

a=[]
c=0
xs.each do |x|
  if x == 3
    a << c unless c == 0
    c = 0
  else
    c += 1
  end
end

pp a.map {|x| tt[x+1]}.inject(&:*)

