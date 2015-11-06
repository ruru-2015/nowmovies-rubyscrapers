require 'mechanize'

class GoogleMovies
  def initialize
    @base_url = "https://www.google.com/movies?near=wellington,&sort=1"
    @Movies = {}
  end
# "#link_1_theater_8547115232414900036"
  def getStuff
    found_movies = []
    showTimes = []
    list = []
    agent = Mechanize.new { |agent|
      agent.user_agent_alias = 'Windows Chrome'
    }
    #get titles of movies
    agent.get(@base_url) { |page|
      page.links_with(:href => /movies\?near=wellington,\&sort=1&mid=/).each do |link|
        description_page = link.click
        title = description_page.search('h2[itemprop="name"]').text.strip
        @Movies[title] = {}
        showTimes = description_page.search(".theater div.times").text.strip
        p showTimes
        description_page.search('.theater .name').each do |cinema|
          cinemaName = cinema.text.strip
          @Movies[title][cinemaName] = list
        end
      end
      p @Movies
    }
  end
end

google_movies = GoogleMovies.new
google_movies.getStuff


