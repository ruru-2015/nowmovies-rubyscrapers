require 'mechanize'

class Lighthouse
  def initialize
    @base_url = "http://www.lighthousepetone.co.nz/movie/schedule/"
    @Movie = Struct.new(:title, :date, :summary)
  end

  def getStuff
    found_movies = []
    dates = []
    agent = Mechanize.new { |agent|
      agent.user_agent_alias = 'Windows Chrome'
    }
    #get titles of movies
    agent.get(@base_url) { |page|
      # page.search(".tr_item").each do |time|
      #   p time.text.strip
      #   # dates << date
      # end
      page.search('.cal_film_title').each do |title|
        current_movie = @Movie.new
        current_movie.title = title.text.strip

        found_movies << current_movie
      end

      found_movies.each do |movie|
        p movie
      end
    }
  end
end

lighthouse = Lighthouse.new
lighthouse.getStuff

