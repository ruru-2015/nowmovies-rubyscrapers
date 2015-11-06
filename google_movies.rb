require 'mechanize'

class GoogleMovies
  def initialize
    @base_url = "https://www.google.com/movies?near=wellington,&sort=1"
    @Movies = {}
  end

  def getStuff
    found_movies = []
    dates = []
    agent = Mechanize.new { |agent|
      agent.user_agent_alias = 'Windows Chrome'
    }
    #get titles of movies
    agent.get(@base_url) { |page|
      page.links_with(:href => /movies\?near=wellington,\&sort=1&mid=/).each do |link|
        description_page = link.click
        title = description_page.search('h2[itemprop="name"]').text.strip
        @Movies[title] = {}
        description_page.search('.theater .name').each do |cinema|
          @Movies[title][cinema.text.strip] = []
        end
      end
      # @Movies.each do |movie|
      #   p movie
      # end
      p @Movies
    }
  end
end

google_movies = GoogleMovies.new
google_movies.getStuff


