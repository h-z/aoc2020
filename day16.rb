file = File.open("input16.txt")
xs = file.readlines.map(&:chomp)

rules = {}
nearby = []
ticket = ''
cmd = :rules

xs.each do |l|
  case cmd
  when :rules
    if l.empty?
      cmd = :your
    else
      key, r = l.split(': ')
      rules[key] = r.split(' or ').map  do |s|
        a = s.split('-')
        a.first.to_i..a.last.to_i
      end
    end
  when :your
    if l.empty?
      cmd = :nearby
    else
      ticket = l.split(',').map(&:to_i)
    end
  when :nearby
    nearby << l.split(',').map(&:to_i)
  end
end
nearby.shift

invalid_fields = []
valid_tickets = []

every_range = rules.values.flatten

nearby.each do |l|
  tmp = l.reject {|i| every_range.any? {|r| r === i } }
  if tmp.empty?
    valid_tickets << l
  else
    invalid_fields << tmp
  end
end

pp invalid_fields.flatten.sum

rules_ok = Hash.new {|hsh, key| hsh[key] = [] }

valid_tickets.transpose.each.with_index do |field, index|
  rules.each do |rule, ranges|
    if field.all? {|v| ranges.any? {|r| r === v } }
      rules_ok[rule] << index
    end
  end
end

def solve(rules, result)
  return result if rules.empty?

  key, fields = rules.find {|k,v| v.size == 1 }
  result[key] = fields.first
  rules.delete(key)
  rules.each {|k,v| rules[k] = v - fields }
  solve(rules, result)
end

rules = solve(rules_ok, {})

pp rules.filter {|k,v| k.start_with?('departure')}.values.map {|v| ticket[v] }.inject(&:*)
