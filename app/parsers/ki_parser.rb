class KIParser < Parser

  BASE_PARSING_URL = 'http://www.ki.agh.edu.pl/aktualnosci/dla-studentow'.freeze

  def initialize
    @url = BASE_PARSING_URL
  end

  def parse
    page = Nokogiri::HTML(open @url)
    news_divs = page.css '.news-teaser'
    news_divs.map do |news_div|
      link = news_div.css('a').first
      news_url = "http://www.ki.agh.edu.pl#{link['href']}"
      {
        posted_at: get_date_from_news_div(news_div),
        title: link.text,
	origin_url: news_url,
        content: get_content_from_url(news_url)
      }
    end
  end

  private

  def get_date_from_news_div news_div
    news_div.css('time').first.attributes['datetime'].value
  end

  def get_content_from_url url
    page = Nokogiri::HTML(open url)
    article = page.css 'article.full'
    content = article.children.reject{ |node| node.name == 'header' }
    strip_line_breaks_and_join content
  end

end
