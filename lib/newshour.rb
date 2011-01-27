require 'rubygems'
require 'mechanize'

class Newshour
	def get_scripts p
	end
	def down
		m = Mechanize.new
		p = m.get 'http://www.pbs.org/newshour/newshour_index.html'
		script = p.search('//b[@class="otn_heading"]/a').map{|x| x[:href]}
		mp3 = p.search('//span[@class="otn_text"]/a').map{|x| x[:href]}
		script.map!{|s| m.get(s).search('//div[@class="copy"]/p').map(&:text).join("\n")}
	end
end
