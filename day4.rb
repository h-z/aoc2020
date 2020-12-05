require 'byebug'

file = File.open("input4.txt")
xs = file.readlines
xs << ''
required_fields = %w[byr iyr eyr hgt hcl ecl pid]
passports = []
passport = {}
xs.each do |l|
  if l.chomp.empty?
    passports << passport
    passport = {}
  end
  passport.merge! l.chomp.split.map{|w| w.split(':')}.to_h
end

valid_passports = passports.select {|passport| (required_fields - passport.keys).empty? }

p valid_passports.size

def check_height(hgt)
  case hgt[-2..-1]
  when 'in'
    ((59..76) === hgt[0..1].to_i) && (hgt.size == 4)
  when 'cm'
    ((150..193) === hgt[0..2].to_i) && (hgt.size == 5)
  end
end

really_valid = valid_passports.select do  |passport|
  (1920..2002) === passport['byr'].to_i &&
    (2010..2020) === passport['iyr'].to_i &&
    (2020..2030) === passport['eyr'].to_i &&
    check_height(passport['hgt']) &&
    /^#[0-9a-f]{6}$/ =~ passport['hcl'] &&
    %w[amb blu brn gry grn hzl oth].include?(passport['ecl']) &&
    /^[0-9]{9}$/ =~ passport['pid']
end

puts really_valid.size
