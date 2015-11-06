require 'mechanize'

class Lighthouse
  def initialize
    @base_url = "https://www.eventcinemas.co.nz/Cinema/Queensgate"
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

      # <a href="/Movie/Scouts-Vs-Zombies"><span class="title">Scouts Guide to the Zombie Apocalypse</span></a>

      page.links_with(:href => /Movie/).each do |title|
        current_movie = @Movie.new
        current_movie.title = title.text.strip
        p title
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

