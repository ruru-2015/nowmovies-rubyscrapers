require 'mechanize'

Movie = Struct.new(:title, :year, :summary)
found_movies = []
agent = Mechanize.new { |agent|
    agent.user_agent_alias = 'Windows Chrome'
}
afisearchpage = "http://www.afi.com/members/catalog/search.aspx?s="
agent.get(afisearchpage) { |page|

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


