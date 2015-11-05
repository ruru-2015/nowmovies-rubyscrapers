require 'mechanize'

mechanize = Mechanize.new

page = mechanize.get('http://www.lighthousepetone.co.nz/movie/schedule/')
puts page.search(".cal_film_title").text.strip

