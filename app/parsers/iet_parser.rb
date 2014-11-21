class IETParser < Parser

  BASE_URL = 'http://www.iet.agh.edu.pl/pl/aktualnosci'.freeze

  def parse
    page       = Nokogiri::HTML(open BASE_URL)
    news_nodes = page.css('.accordion-item a')
    news_nodes.map do |news_node|
      {
        origin_url: news_node['href'],
        posted_at:  get_date(news_node),
        title:      get_title(news_node),
        content:    get_content(news_node['href'])
      }
    end
  end

  private

  def get_date(news_node)
    text = news_node.at_css('.news-date').text
    Time.strptime(text, '%d.%m.%Y')
  end

  def get_title(news_node)
    strip_line_breaks(news_node.xpath('text()'))
  end

  def get_content(url)
    page    = Nokogiri::HTML(open url)
    content = page.at_css('.accordion-pane')
    strip_line_breaks(content)
  end
end
