require 'byebug'
file = File.open("input12.txt")
xs = file.readlines

x = 0
y = 0
f = 'E'
facings = ['E', 'S', 'W', 'N', 'E', 'S', 'W', 'N']


xs.each do |l|
  d = l[1..-1].to_i

  case l[0]
  when 'N'
    x += d
  when 'S'
    x -= d
  when 'E'
    y += d
  when 'W'
    y -= d
  when 'R'
    f = facings[facings.index(f) + (d / 90)]
  when 'L'
    f = facings[facings.index(f) - (d / 90)]
  when 'F'
    case f
    when 'N'
      x += d
    when 'S'
      x -= d
    when 'E'
      y += d
    when 'W'
      y -= d
    end
  end
end

pp x.abs + y.abs

x = 0
y = 0
wx = 1
wy = 10

xs.each do |l|
  d = l[1..-1].to_i

  case l[0]
  when 'N'
    wx += d
  when 'S'
    wx -= d
  when 'E'
    wy += d
  when 'W'
    wy -= d
  when 'R'
    (d / 90).times do
      wx, wy = -wy, wx
    end
  when 'L'
    (d / 90).times do
      wx, wy = wy, -wx
    end
  when 'F'
    x += wx * d
    y += wy * d
  end
end

pp x.abs + y.abs
