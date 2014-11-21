class SJOParser < Parser

  BASE_URL = 'http://home.agh.edu.pl/~sjo'.freeze

  def parse
    page = Nokogiri::HTML(get_page)
    news_nodes = page.css('#newsmain li')
    news_nodes.map do |news_node|
      link = news_node.css('a').first
      {
        title:      link.text,
        origin_url: link['href'],
        posted_at:  get_date(news_node),
        content:    get_content(link['href'])
      }
    end
  end

  private

  def get_page
    open(BASE_URL).string.gsub('<b>', '').gsub('</b>', '')
  end

  def get_date(news_node)
    text = news_node.at_css('em').text
    Time.strptime(text, '%Y-%m-%d')
  end

  def get_content(url)
    page    = Nokogiri::HTML(open url)
    content = page.at_css('#news')
    content.at_css('h4').remove
    content.at_css('em').remove
    strip_line_breaks(content)
  end
end
