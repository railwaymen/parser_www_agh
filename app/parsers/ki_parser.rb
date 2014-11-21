class KIParser < Parser

  BASE_URL = 'http://www.ki.agh.edu.pl/aktualnosci/dla-studentow'.freeze

  def parse
    page       = Nokogiri::HTML(open BASE_URL)
    news_nodes = page.css('.news-teaser')
    news_nodes.map do |news_node|
      link     = news_node.css('a').first
      news_url = "http://www.ki.agh.edu.pl#{link['href']}"
      {
        title:      link.text,
        origin_url: news_url,
        posted_at:  get_date(news_node),
        content:    get_content(news_url)
      }
    end
  end

  private

  def get_date(news_node)
    text = news_node.css('time').first.attributes['datetime'].value
    Time.strptime(text, '%Y-%m-%d')
  end

  def get_content(url)
    page    = Nokogiri::HTML(open url)
    content = page.at_css('article.full')
    content.css('header').remove
    strip_line_breaks(content)
  end
end
