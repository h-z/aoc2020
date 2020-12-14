require 'byebug'
file = File.open("input11.txt")
xs = file.readlines.map(&:chomp).map(&:chars)

#     X  Y
#     l  w
#  xs[0][1]

def neighbors1(x, y, b)
  ns = []
  if x-1 > -1
    ns << [b[x-1][y], b[x-1][y+1]]
    ns << b[x-1][y-1] if y-1 > -1
  end
  if y-1 > -1
    ns << b[x][y-1]
    ns << b[x+1][y-1] if b[x+1]
  end
  ns << b[x][y+1]
  ns << [b[x+1][y+1], b[x+1][y]] if b[x+1]
  ns.flatten.count('#')
end

def neighbors2(x, y, b)
  ns = []
  y1 = [y-1, 0].max
  x1 = [x-1, 0].max
  ns << b[x][0..y1].reverse.find {|c| c != '.' } unless y.zero?
  ns << b[x][y+1..-1].find {|c| c != '.' } unless y == b.first.size - 1
  ns << b.transpose[y][0..x1].reverse.find {|c| c != '.' } unless x.zero?
  ns << b.transpose[y][x+1..-1].find {|c| c != '.' } unless x == b.size - 1

  ns << [x,y].min.times.map { |i| b[x1-i][y1-i]}.find {|c| c != '.' }
  ns << [b.size-x-1,y].min.times.map { |i| b[x+i+1][y1-i]}.find {|c| c != '.' }
  ns << [b.first.size-y-1,x].min.times.map { |i| b[x1-i][y+i+1] }.find {|c| c != '.' }
  ns << [b.first.size-y-1,b.size-x-1].min.times.map { |i| b[x+i+1][y+i+1] }.find {|c| c != '.' }

  ns.count('#')
end

def change(x,y,b, type)
  ns = send(:"neighbors#{type}", x, y, b)
  max_occupied = { 1 => 4, 2 => 5 }[type]

  case b[x][y]
  when 'L'
    ns == 0 ? '#' : 'L'
  when '#'
    ns >= max_occupied ? 'L' : '#'
  else
    b[x][y]
  end
end

def round(b, type)
  y = b.first.size
  x = b.size
  new_board = Array.new(x) { Array.new(y) { '.' } }

  b.size.times do |x|
    b[x].size.times do |y|
      new_board[x][y] = change(x, y, b, type)
    end
  end
  new_board
end

loop do
  nxs = round(xs, 1)
  break if xs == nxs
  xs = nxs
end

pp xs.join.count('#')
