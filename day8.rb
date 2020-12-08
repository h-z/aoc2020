file = File.open("input8.txt")
xs = file.readlines

xs.map! do |l|
  cmd, arg = l.split
  [cmd, arg.to_i]
end.freeze

def run(xs, normal = false)
  acc = 0
  idx = 0
  visited = []
  loop do
    if visited.include?(idx)
      unless normal
        puts "loop found: #{acc}"
      end
      break
    end
    if xs[idx].nil?
      puts "normal termination found: #{acc}"
      break
    end
    visited << idx
    case xs[idx].first
    when 'acc'
      acc += xs[idx].last
      idx += 1
    when 'jmp'
      idx += xs[idx].last
    else
      idx += 1
    end
  end
end

run(xs)

swap = {'nop' => 'jmp', 'jmp' => 'nop'}
xs.each.with_index do |l, i|
  unless l.first == 'acc'
    xs1 = xs.dup
    xs1[i] = [swap[xs1[i][0]], xs1[i][1]]
    run(xs1, true)
  end
end
