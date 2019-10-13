require 'base64'

SM_A = 'a'[0].ord
LG_A = 'A'[0].ord

class String
  def rot(num = 13)
    return self.split("").collect { |ch|
      if /^[a-z]$/ === ch
        ((ch[0].ord + num - SM_A) % 26 + SM_A).chr
      elsif /^[A-Z]$/ === ch
        ((ch[0].ord + num - LG_A) % 26 + LG_A).chr
      else
	      ch
      end
    }.join("")
  end

  alias rot13 rot

  def self.rnd(len)
    (0...len).map { (65 + rand(26)).chr }.join
  end

  def ^( other )
    b1 = self.unpack("U*")
    b2 = other.unpack("U*")
    longest = [b1.length,b2.length].max
    b1 = [0]*(longest-b1.length) + b1
    b2 = [0]*(longest-b2.length) + b2
    b1.zip(b2).map{ |a,b| a^b }.pack("U*")
  end
end

c5 = File.read('src/assets/challenge5.txt')
rot = c5.rot
puts "Rotated:"
puts rot
puts

k = String.rnd(c5.length)
puts "Key:"
puts k
File.write("k", k)
puts

x = rot ^ k
puts "XOR:"
puts x

x = Base64.strict_encode64(x)
puts "Encoded:"
puts x
File.write("f", x)
puts

puts "==="
puts

xb = Base64.strict_decode64(x) ^ k
puts "Decoded & XOR back"
puts xb

puts "Rotated back:"
puts xb.rot
