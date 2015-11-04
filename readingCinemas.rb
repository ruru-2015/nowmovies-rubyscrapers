require 'mechanize'

class Reading

  def initialize
    @base_url = "http://readingcinemas.co.nz/now_showing"
    @movie = Struct.new(:title, :year, :summary)
  end

  def getStuff
    found_movies = []
    cat = @movie.new
    puts cat
    agent = Mechanize.new { |agent|
      agent.user_agent_alias = 'Windows Chrome'
    }

    agent.get(readingSearchPage) { |page|
      results = page.form_with(:name => 'Search') do |search|
        search.SearchText = 'amazon' end.submit
        results.links_with(:href => /DetailView.aspx\?s=\&Movie=/).each do |link|
          puts link
          current_movie = Movie.new
          current_movie.year = link.text.match(/\(\d{4}\)$/)[0].gsub(/\D/, "")
          description_page = link.click
          description_page.search("//center//b").each do |node|
            current_movie.title = node.text.strip;
          end
          description_page.search("//td//tr[contains(., 'Summary:')]/td[2]").each do |node|
            if ((node.text =~ /\w/))
              current_movie.summary = node.text.strip
            end
          end

          found_movies << current_movie
        end

      }
      found_movies.each do |movie|
        p movie
      end
    end
end


reading = Reading.new
reading.getStuff
