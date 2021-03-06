require 'rubygems'
require 'mechanize'

class Newshour
	def down
		m = Mechanize.new
		p = m.get 'http://www.pbs.org/newshour/newshour_index.html'
		script = p.search('//b[@class="otn_heading"]/a').map do |x| 
			m.get(x[:href]).search('//div[@class="copy"]/p').map(&:text).join("\n")
		end
		mp3 = p.search('//span[@class="otn_text"]/a').map{|x| x[:href]}
		puts mp3.length
		0.upto(mp3.length-1) do |i|
			puts "Download ##{i}"
			File.open("script##{i}.txt", 'w') {|f| f.write(script[i]) }
			m.get(mp3[i]).save_as("mp3##{i}.mp3")
		end
	end
end

Newshour.new.down
