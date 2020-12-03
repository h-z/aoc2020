file = File.open("input2.txt")
xs = file.readlines
i=0
j=0
xs.each do |l|
  l.scan(/(\d+)-(\d+) ([a-z]): (.*)/) do |a, b, char, password|
    a = a.to_i
    b = b.to_i
    i += 1 if (a..b) === password.count(char)
    j += 1 if (password[a-1]==char) ^ (password[b-1]==char)
  end
end

puts i
puts j
