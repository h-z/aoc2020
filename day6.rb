file = File.open("input6.txt")
xs = file.readlines

p xs.join.split("\n\n").map { |l| l.gsub(/\n/, '').chars.uniq.count }.sum

p xs.join.split("\n\n").map { |l| l.split.map(&:chars).inject(&:&).count }.sum
