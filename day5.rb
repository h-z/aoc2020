require 'byebug'

file = File.open("input5.txt")
xs = file.readlines
ids = xs.map do |l|
  l.tr('BFRL', '1010').to_i(2)
end

p ids.max

p (ids.min..ids.max).to_a.reject {|id| ids.include?(id) }
