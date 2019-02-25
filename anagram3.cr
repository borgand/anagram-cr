# Author: Laas Toom <laas@toom.ee>
# Language: Crystal 0.27.2
start = Time.monotonic

dict = ARGV[0]
in_bytes = ARGV[1].chomp.downcase.encode("ISO-8859-15") 
input = String.new(in_bytes, "ISO-8859-15")
inputCounts = input.chars.reduce({} of Char => Int8){|counts, c| counts[c] ||= 0; counts[c] += 1; counts}

anagrams = [] of String
f = File.open(dict, mode = "r")
f.set_encoding("ISO-8859-15")
f.each_line do |w|
  w = w.chomp.downcase
  next if w.size != input.size
  anagrams << w if inputCounts == w.chars.reduce({} of Char => Int8){|counts, c| counts[c] ||= 0; counts[c] += 1; counts}
end

duration = (Time.monotonic - start).to_f * 1_000_000 # get microseconds
puts "#{duration.to_i}, #{anagrams.join(", ")}"
