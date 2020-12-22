file = File.open("input14.txt")
xs = file.readlines

mask = ''
mem = {}
xs.each do |l|
  cmd, value = l.split(' = ')

  if cmd == 'mask'
    mask = value.chomp.chars
  else
    mem[cmd.scan(/\[(.*)\]/i).first.first.to_i] =
    value
      .chomp
      .to_i
      .to_s(2)
      .rjust(mask.size, '0')
      .chars
      .zip(mask).map {|a, b| b == 'X' ? a : b }.join.to_i(2)
  end
end

p mem.values.sum

mask = ''
mem = {}

def combos(addresses)
  addresses.map do |address|
  idx = address.index('X')
  return [address] if idx.nil?

  combos([address.dup.tap {|s| s[idx] = '0'}]) +
  combos([address.dup.tap {|s| s[idx] = '1'}])
  end
end

xs.each do |l|
  cmd, value = l.split(' = ')

  if cmd == 'mask'
    mask = value.chomp.chars
  else
    address = cmd.scan(/\[(.*)\]/i).first.first
      .to_i
      .to_s(2)
      .rjust(mask.size, '0')
      .chars
      .zip(mask).map {|a, b| b == '0' ? a : ( b == '1' ? '1' : 'X')}
      .join
    combos([address]).flatten.each do |address|
      mem[address] = value.to_i
    end
  end
end

p mem.values.sum
